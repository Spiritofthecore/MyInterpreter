//
//  UserDashboardVC.swift
//  MyInterpreter
//
//  Created by Tom on 5/26/19.
//  Copyright © 2019 Tom. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class UserDashboardVC: UIViewController {
    
    // MARK: UI elements
    @IBOutlet weak var interpreterProfileImage: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    // Params
    var cache = NSCache<AnyObject, AnyObject>()
    var interpreter = Interpreter()
    var timer = Timer()
    
    let dataRef = Database.database().reference()
    
    // MARK: Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(bookingExpired), userInfo: nil, repeats: true)
        
        getInterpreter()
        
        setUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        timer.invalidate()
    }
    
    // MARK: Work place
    private func setUI()
    {
        let userButton = UIBarButtonItem(image: #imageLiteral(resourceName: "userIcon"), style: .plain, target: self, action: #selector(userButtonClicked))
        navigationItem.rightBarButtonItem = userButton
        
        navigationItem.setCustomNavBar(title: "Dashboard")
        navigationItem.hidesBackButton = true
        
        interpreterProfileImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(photoPickerController)))
        interpreterProfileImage.isUserInteractionEnabled = true
        interpreterProfileImage.layer.cornerRadius = interpreterProfileImage.frame.height/2
        
        interpreterProfileImage.layer.borderWidth = 3
        interpreterProfileImage.layer.borderColor = UIColor.blue.cgColor
    }

    func getInterpreter()
    {
        spinner.startAnimating()
        
        DispatchQueue.global().async {
            
            // Get booking object of current user
            let userBookingRef = self.dataRef.child("users").child((Auth.auth().currentUser?.email?.getEncodedEmail())!).child("booking")
            
            userBookingRef.observe(.value, with: { (bookingSnapshot: DataSnapshot) in
                
                let bookingID = bookingSnapshot.value as! String
                
                // Get booked interpreter info
                let booking = self.dataRef.child("bookings").child(bookingID)
                
                booking.observe(.value, with: { (bookingIdSnapshot: DataSnapshot) in
                    
                    guard let bookingObject = bookingIdSnapshot.value as? NSDictionary else
                    {
                        return
                    }
                    
                    if let interpreterBooked = bookingObject["interpreter"] as? String
                    {
                        let interpreterRef = self.dataRef.child("interpreters").child(interpreterBooked)
                        
                        interpreterRef.observe(.value, with: { (interpreterSnapshot: DataSnapshot) in
                            
                            guard let interpreterObject = interpreterSnapshot.value as? NSDictionary else
                            {
                                self.customAlertAction(title: "Error!", message: "Can't observe interpreter info from database")
                                return
                            }
                            
                            if let name = interpreterObject["name"] as? String,
                                let email = interpreterObject["email"] as? String,
                                let status = interpreterObject["status"] as? Bool,
                                let motherLanguage = interpreterObject["motherLanguage"] as? String,
                                let secondLanguage = interpreterObject["secondLanguage"] as? String,
                                let profileImageURL = interpreterObject["profileImageURL"] as? String
                            {
                                self.interpreter.name = name
                                self.interpreter.email = email
                                self.interpreter.status = status
                                self.interpreter.motherLanguage = motherLanguage
                                self.interpreter.secondLanguage = secondLanguage
                                self.interpreter.profileImageURL = profileImageURL
                                
                                if let img = self.cache.object(forKey: "interpreterImageURL" as AnyObject)
                                {
                                    self.interpreterProfileImage.image = img as? UIImage
                                }
                                else
                                {
                                    let url = URL(string: self.interpreter.profileImageURL)
                                    
                                    guard let data = NSData(contentsOf: url!)
                                        else {
                                            self.customAlertAction(title: "Error!", message: "Something wrong with your profile image!")
                                            return
                                    }
                                    DispatchQueue.main.async
                                        {
                                            
                                            self.interpreterProfileImage.image = UIImage(data: data as Data)
                                            self.cache.setObject(self.interpreterProfileImage.image!, forKey: "interpreterImageURL" as AnyObject)
                                            
                                            self.spinner.stopAnimating()
                                    }
                                }
                            }
                        })
                    }
                })
                
                
            })
        }
    }
    
    @objc func bookingExpired()
    {
        DispatchQueue.global().async {
            // Get booking object of current user
            let userBookingRef = self.dataRef.child("users").child((Auth.auth().currentUser?.email?.getEncodedEmail())!).child("booking")
            
            userBookingRef.observe(.value, with: { (bookingSnapshot: DataSnapshot) in
                
                let bookingID = bookingSnapshot.value as! String
                
                // Get booked interpreter info
                let booking = self.dataRef.child("bookings").child(bookingID)
                
                booking.observe(.value, with: { (bookingIdSnapshot: DataSnapshot) in
                    
                    guard let bookingObject = bookingIdSnapshot.value as? NSDictionary else
                    {
                        return
                    }
                    
                    let endTimeFormatter = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.medium)
                    let endTemp = String().dateFormatter_dropAMPM(date: endTimeFormatter)
                    
                    let endTime = String().dateFormatter(date: (bookingObject["timeEnd"] as? String)!)
                    print("\(endTemp) - \(endTime)")
                    if endTime == endTemp
                    {
                        self.timer.invalidate()
                        userBookingRef.setValue("interpreter0")
                        DispatchQueue.main.async {
                            
                            self.navigationController?.popViewController(animated: true)
                            
                            let listInterpreterVC = self.storyboard!.instantiateViewController(withIdentifier: "ListInterpretersVC")
                            self.navigationController?.pushViewController(listInterpreterVC, animated: true)
                            
                            self.customAlertAction(title: "Notice!", message: "Your booking has just been expired! Thank you for choosing us!")
                            
                        }
                    }
                })
            })
        }
        
    }
    
    
    // MARK: ---BUTTON---
    @objc func photoPickerController()
    {
        let controller = ChatLogController()
        controller.userId = ((Auth.auth().currentUser?.email?.getEncodedEmail())!)
        controller.interpreterEmail = interpreter.email
        controller.chatter = "user"
        if let notChatterProfileImage = interpreterProfileImage.image {
            controller.leftCellProfileImage = notChatterProfileImage
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    @objc func userButtonClicked()
    {
        UserInfoVC.objectID = (Auth.auth().currentUser?.email?.getEncodedEmail())!
        performSegue(withIdentifier: "userInfoSegue", sender: nil)
    }
    
    
    @IBAction func interpreterProfileButtonClicked(_ sender: Any) {
        UserInfoVC.objectID = interpreter.email.getEncodedEmail()
        performSegue(withIdentifier: "userInfoSegue", sender: nil)
    }
}
