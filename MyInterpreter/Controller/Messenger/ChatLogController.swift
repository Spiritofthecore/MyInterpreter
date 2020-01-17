//
//  ChatLogController.swift
//  ChatApp
//
//  Created by Macbook on 4/21/19.
//  Copyright © 2019 Spiritofthecore. All rights reserved.
//

import UIKit
import Firebase

class ChatLogController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var chatter: String = ""
    var interpreterEmail: String = ""
    var userId: String = ""
    var messages: [Message] = []
    var leftCellProfileImage: UIImage?
    var cache = NSCache<AnyObject, AnyObject>()
    var doneCellCount: Int = 0

    func downloadImage(from urlString: String, completion: @escaping (UIImage) -> ()) {
        if let cachedImage = cache.object(forKey: urlString as AnyObject) {
            completion(cachedImage as! UIImage)
        } else {
            DispatchQueue.global().async {
                let imageURL = URL(string: urlString)
                let data = NSData(contentsOf: imageURL!)
                DispatchQueue.main.async {
                    guard let data = data else {
                        return
                    }
                    self.cache.setObject(UIImage(data: data as Data)!, forKey: urlString as AnyObject)
                    completion(UIImage(data: data as Data)!)
                }
            }
        }
    }
    
    func applyImageTapGesture(to view: UIView) {
        view.isUserInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(imageTapDetected(sender:)))
        singleTap.numberOfTapsRequired = 1
        singleTap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(singleTap)
    }
    
    private let cellID = "cellID"
    let tableView = UITableView()
    
    let messageInputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let inputTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter Message..."
        return textField
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        return button
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.addTarget(self, action: #selector(plusButtonTouch), for: .touchUpInside)
        return button
    }()
    
    
    
    var messageInputBottomAnchor: NSLayoutConstraint?
    var messageInputActivateBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let guide = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        let backgroundView = UIImageView()
        backgroundView.image = #imageLiteral(resourceName: "background")
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backgroundView)
        backgroundView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        backgroundView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
        backgroundView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        
        hideKeyboard()
        
        observeMessage()
        
        
        tabBarController?.tabBar.isHidden = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.293557363)
        tableView.register(ChatLogMessageCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorColor = .clear
        tableView.allowsSelection = false
        
        view.addSubview(messageInputContainerView)
        messageInputContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        messageInputBottomAnchor = messageInputContainerView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: 0)
        messageInputBottomAnchor?.isActive = true
        messageInputActivateBottomAnchor = messageInputContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        messageInputActivateBottomAnchor?.isActive = false
        messageInputContainerView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
        messageInputContainerView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        messageInputContainerView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: messageInputContainerView.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: guide.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: guide.rightAnchor).isActive = true
        
        
        
        setUpInputComponent()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func scrollToBottom(){
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: self.doneCellCount - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    func observeMessage() {
        let firebaseObserver = FirebaseHandler()
        firebaseObserver.delegate = self
        firebaseObserver.addMessageObserver(for: userId, interpreterEmail: interpreterEmail)
    }
    
    @objc func sendMessage() {
        if (inputTextField.text != "") {
            let firebaseHandler = FirebaseHandler()
            if (Auth.auth().currentUser?.email!.getEncodedEmail().contains("interpreter"))! {
                firebaseHandler.sendTextMessage(sender: chatter, text: inputTextField.text!, userId: userId, interpreterId: (Auth.auth().currentUser?.email!.getEncodedEmail())!)
            } else {
                firebaseHandler.sendTextMessage(sender: chatter, text: inputTextField.text!, userId: userId, interpreterId: interpreterEmail.getEncodedEmail())
            }
            self.inputTextField.text = ""
        }
    }
    
    @objc func plusButtonTouch() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Create your actions - take a look at different style attributes
        let sendImageAction = UIAlertAction(title: "Send Image", style: .default) { (action) in
            // observe it in the buttons block, what button has been pressed
            self.sendImageButtonTouched()
        }
        
        let sendVideo = UIAlertAction(title: "Send Video", style: .default) { (action) in
            print("didPress send video")
        }
        
        let sendAudio = UIAlertAction(title: "Send Audio", style: .default) { (action) in
            print("didPress send audio")
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print("didPress cancel")
        }
        
        // Add the actions to your actionSheet
        actionSheet.addAction(sendImageAction)
        actionSheet.addAction(sendVideo)
        actionSheet.addAction(sendAudio)
        actionSheet.addAction(cancelAction)
        // Present the controller
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: send image
    func sendImageButtonTouched() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = .photoLibrary
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info[.editedImage] as? UIImage {
            selectedImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            selectedImage = originalImage
        }
        
        guard  let image = selectedImage else {
            return
        }
        
        uploadMessageToFirebase(using: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func uploadMessageToFirebase(using messageImage: UIImage) {
        let firebaseRef = FirebaseHandler()
        let storageRef = firebaseRef.getNewMessageImageStorageReference(userId: userId, interpreterId: interpreterEmail.getEncodedEmail())
        
        if let messageImageData = messageImage.pngData()
        {
            storageRef.putData(messageImageData, metadata: nil) { (metaData, error) in
                if error != nil
                {
                    self.alertAction(title: "Uploading image failed!", message: String(describing: error))
                    return
                }
                storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
                    if error != nil
                    {
                        self.alertAction(title: "Uploading image failed!", message: String(describing: error))
                        return
                    }
                    let urlString = url?.absoluteString
                    let firebaseHandler = FirebaseHandler()
                    firebaseHandler.sendImageMessage(sender: self.chatter, imageURL: urlString ?? "", userId: self.userId, interpreterId: self.interpreterEmail.getEncodedEmail())
                })
                
            }
        }
    }
    
    private func alertAction(title: String, message: String)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func handleKeyboardNotification(notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            if (isKeyboardShowing) {
                messageInputActivateBottomAnchor?.constant = -keyboardRectangle.height
                messageInputBottomAnchor?.isActive = false
                messageInputActivateBottomAnchor?.isActive = true
            } else {
                messageInputActivateBottomAnchor?.isActive = false
                messageInputBottomAnchor?.isActive = true
            }
            UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }) { (completed) in
                
            }
        }
    }
    
    @objc func imageTapDetected(sender: UITapGestureRecognizer) {
        let imageView = sender.view as? UIImageView
        let controller = FullImageViewController()
        controller.image = imageView?.image
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private func setUpInputComponent() {
        messageInputContainerView.addSubview(inputTextField)
        messageInputContainerView.addSubview(sendButton)
        messageInputContainerView.addSubview(plusButton)
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        plusButton.leadingAnchor.constraint(equalTo: messageInputContainerView.leadingAnchor).isActive = true
        plusButton.heightAnchor.constraint(equalTo: messageInputContainerView.heightAnchor).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor).isActive = true
        
        inputTextField.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor).isActive = true
        inputTextField.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor).isActive = true
        inputTextField.heightAnchor.constraint(equalTo: messageInputContainerView.heightAnchor, multiplier: 1).isActive = true
        inputTextField.widthAnchor.constraint(equalToConstant: self.view.frame.width - 110).isActive = true
        
        sendButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        sendButton.leadingAnchor.constraint(equalTo: inputTextField.trailingAnchor).isActive = true
        sendButton.heightAnchor.constraint(equalTo: messageInputContainerView.heightAnchor).isActive = true
        sendButton.bottomAnchor.constraint(equalTo: messageInputContainerView.bottomAnchor).isActive = true
    }
}

extension ChatLogController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (messages.count == 0) {
            tableView.setEmptyView(title: "Chat log is empty", message: "Your conversation here")
        } else {
            tableView.restore()
        }
        return messages.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ChatLogMessageCell
        let director = Director()
        if messages[indexPath.row].imageURL != "" {
            director.update(builder: ImageCellBuilder())
            if let cachedImage = cache.object(forKey: messages[indexPath.row].imageURL as AnyObject) as? UIImage {
                if (self.messages[indexPath.row].sender != chatter) {
                    director.buildLeftImageCell(image: cachedImage, viewSize: self.view.frame.size, avatarImage: leftCellProfileImage ?? UIImage(named: "userIcon")!)
                    cell.cellComponents = director.getProduct()
                } else {
                    director.buildRightImageCell(image: cachedImage, viewSize: self.view.frame.size)
                    cell.cellComponents = director.getProduct()
                }
                self.applyImageTapGesture(to: cell.cellComponents)
            } else {
                director.update(builder: IndicatorCellBuilder())
                if (self.messages[indexPath.row].sender != chatter) {
                    director.buildLeftLoadingCell(viewWidth: self.view.frame.width, avatarImage: leftCellProfileImage ?? UIImage(named: "userIcon")!)
                    cell.cellComponents = director.getProduct()
                } else {
                    director.buildRightLoadingCell(viewSize: self.view.frame.size)
                    cell.cellComponents = director.getProduct()
                }
            }
        } else if messages[indexPath.row].text != "" {
            director.update(builder: TextCellBuilder())
            if (self.messages[indexPath.row].sender != chatter) {
                director.buildLeftTextCell(text: messages[indexPath.row].text, viewWidth: self.view.frame.width, avatarImage: leftCellProfileImage ?? UIImage(named: "userIcon")!)
                cell.cellComponents = director.getProduct()
            } else {
                director.buildRightTextCell(text: messages[indexPath.row].text, viewWidth: self.view.frame.width)
                cell.cellComponents = director.getProduct()
            }
        }
        cell.addComponents()
        return cell
    }
}

extension ChatLogController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if messages[indexPath.row].imageURL != "" {
            return calculateImageCellHeight(indexPath: indexPath)
        } else if messages[indexPath.row].text != "" {
            return calculateTextCellHeight(indexPath: indexPath)
        } else {
            return 100
        }
    }

    
    func calculateTextCellHeight(indexPath: IndexPath) -> CGFloat {
        let text = messages[indexPath.row].text
        let sizeToFit = CGSize(width: view.frame.width * 2 / 3, height: CGFloat.greatestFiniteMagnitude)
        
        return text.getTextViewRect(sizeToFit: sizeToFit, font: UIFont.systemFont(ofSize: 16), startPoint: CGPoint(x: 0, y: 0)).height + 20
    }
    
    func calculateImageCellHeight(indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        
        if let cachedImage = cache.object(forKey: messages[indexPath.row].imageURL as AnyObject) as? UIImage {
            let ratio = cachedImage.size.width / cachedImage.size.height
            let maxWidth = self.view.frame.width / 3 * 2
            let maxHeight = self.view.frame.height / 3
            
            if ratio > 1.0 { //landscape image
                height = maxWidth / ratio + 20
            } else {
                height = maxHeight + 20
            }
        }
        
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 8)
        return headerView
    }
}

extension ChatLogController: FirebaseObserverDelegation {
    func addMessage(message: Message) {
        self.messages.append(message)
        if message.imageURL != "" {
            self.downloadImage(from: message.imageURL, completion: { _ in
                self.tableView.reloadData()
                self.doneCellCount = self.doneCellCount + 1
                self.scrollToBottom()
            })
        } else {
            self.tableView.reloadData()
            self.doneCellCount = self.doneCellCount + 1
            self.scrollToBottom()
        }
    }
}
