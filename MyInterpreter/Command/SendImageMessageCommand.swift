//
//  SendImageMessageCommand.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/16/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation
import Firebase

class SendImageMessageCommand: FirebaseCommand {
    var sender: String
    var imageURL: String
    var userId: String
    var interpreterId: String
    
    init(sender: String, imageURL: String, userId: String, interpreterId: String) {
        self.sender = sender
        self.imageURL = imageURL
        self.userId = userId
        self.interpreterId = interpreterId
    }
    
    override func execute() {
        let stringDate = Date().getString(with: dateFormat)
        messagesReference.childByAutoId().updateChildValues(["sender": sender, "image": imageURL, "user": userId, "interpreter": interpreterId, "time": stringDate])
    }
}
