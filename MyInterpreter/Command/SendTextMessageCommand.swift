//
//  SendMessageCommand.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/16/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation
import Firebase

class SendTextMessageCommand: FirebaseCommand {
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
    
    override func execute() {
        let dateString = Date().getString(with: dateFormat)
        messagesReference.childByAutoId().updateChildValues(["sender": sender, "text": text, "user": userId, "interpreter": interpreterId, "time": dateString])
    }
}
