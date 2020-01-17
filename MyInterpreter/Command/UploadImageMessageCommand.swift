//
//  UploadImageMessageCommand.swift
//  MyInterpreter
//
//  Created by CuongH on 1/17/2 R.
//  Copyright © 2 Reiwa Tom. All rights reserved.
//

import UIKit
import Firebase

protocol UploadImageMessageDelegate {
    func handleNewChanges(error: Error?, urlString: String?)
}

class UploadImageMessageCommand: FirebaseCommand {
    let userId: String
    let interpreterId: String
    let messageImage: UIImage
    var delegate: UploadImageMessageDelegate?
    init(userId: String, interpreterId: String, messageImage: UIImage) {
        self.userId = userId
        self.interpreterId = interpreterId
        self.messageImage = messageImage
    }
    override func execute() {
        let stringDate = Date().getString(with: dateFormat)
        let fileName = userId + interpreterId + stringDate + ".png"
        let storageRef = Storage.storage().reference().child("message_images").child(fileName)
        
        if let messageImageData = messageImage.pngData()
        {
            storageRef.putData(messageImageData, metadata: nil) { (metaData, error) in
                if let error = error {
                    self.delegate?.handleNewChanges(error: error, urlString: nil)
                    return
                }
                storageRef.downloadURL(completion: { (url: URL?, error: Error?) in
                    let urlString = url?.absoluteString
                    self.delegate?.handleNewChanges(error: error, urlString: urlString)
                })
            }
        }
    }
}
