//
//  UserInfoVC.swift
//  MyInterpreter
//
//  Created by Tom on 6/4/19.
//  Copyright © 2019 Tom. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserInfoVC: UIViewController {

    
    // MARK: Views
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    // MARK: Work place
    private func setUI()
    {
        let logOutButton = UIBarButtonItem(title: "Log Out", style: .plain, target: self, action: #selector(logOutButtonClicked))
        
        navigationItem.rightBarButtonItem = logOutButton
        navigationItem.setCustomNavBar(title: "Profile")
    }
    
    @objc func logOutButtonClicked()
    {
        try! Auth.auth().signOut()
        
        dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }

  

}
