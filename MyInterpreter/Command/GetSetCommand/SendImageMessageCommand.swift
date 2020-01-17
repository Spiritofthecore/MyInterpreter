//
//  SendImageMessageCommand.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/16/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation
import Firebase

class SendImageMessageCommand: GetSetCommand {
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
    
    func execute() {
        let stringDate = self.getDateFormat()
        let messageRef = self.getMessageReference()
        messageRef.updateChildValues(["sender": sender, "image": imageURL, "user": userId, "interpreter": interpreterId, "time": stringDate])
    }
    
    func getMessageReference() -> DatabaseReference {
        return Database.database().reference().child("messages").childByAutoId()
    }
}
