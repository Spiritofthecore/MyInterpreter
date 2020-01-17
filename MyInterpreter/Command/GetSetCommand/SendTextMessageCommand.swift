//
//  SendMessageCommand.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/16/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation
import Firebase

class SendTextMessageCommand: GetSetCommand {
    var sender: String
    var text: String
    var userId: String
    var interpreterId: String
    init(sender: String, text: String, userId: String, interpreterId: String) {
        self.sender = sender
        self.text = text
        self.userId = userId
        self.interpreterId = interpreterId
    }
    
    func getMessageReference() -> DatabaseReference {
        return Database.database().reference().child("messages").childByAutoId()
    }
    
    func execute() {
        let stringDate = self.getDateFormat()
        let messageRef = self.getMessageReference()
        messageRef.updateChildValues(["sender": sender, "text": text, "user": userId, "interpreter": interpreterId, "time": stringDate])
    }
}
