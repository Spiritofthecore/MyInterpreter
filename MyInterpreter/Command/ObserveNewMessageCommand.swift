//
//  ObserveNewMessageCommand.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/16/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation
import Firebase

protocol NewMessagesDelegate {
    func handleNewChanges(message: Message)
}

class ObserveNewMessagesCommand: FirebaseCommand {
    var observer: NewMessagesDelegate?
    var messageHandle: DatabaseHandle?
    var userId: String
    var interpreterId: String
    init(userId: String, interpreterId: String) {
        self.userId = userId
        self.interpreterId = interpreterId
    }
    override func execute() {
        messageHandle = messagesReference.queryOrdered(byChild: "user").queryEqual(toValue: userId).observe(.childAdded) { (snapshot) in
            guard let newMessage = snapshot.value as? NSDictionary else {
                return
            }
//            if (Auth.auth().currentUser?.email?.contains("interpreter"))! {
//                self.interpreterId = (Auth.auth().currentUser?.email?.getEncodedEmail())!
//            }
            guard (newMessage.value(forKey: "interpreter") as? String == self.interpreterId) else {
                return
            }
            var message = Message()
            if (newMessage.value(forKey: "image") != nil) {
                message = Message(sender: newMessage.value(forKey: "sender") as! String, imageURL: newMessage.value(forKey: "image") as! String, user: newMessage.value(forKey: "user") as! String, interpreter: newMessage.value(forKey: "interpreter") as! String, time: newMessage.value(forKey: "time") as! String)
            } else if (newMessage.value(forKey: "text") != nil) {
                message = Message(sender: newMessage.value(forKey: "sender") as! String, text: newMessage.value(forKey: "text") as! String, user: newMessage.value(forKey: "user") as! String, interpreter: newMessage.value(forKey: "interpreter") as! String, time: newMessage.value(forKey: "time") as! String)
            } else if (newMessage.value(forKey: "video") != nil) {
                message = Message(sender: newMessage.value(forKey: "sender") as! String, videoURL: newMessage.value(forKey: "video") as! String, user: newMessage.value(forKey: "user") as! String, interpreter: newMessage.value(forKey: "interpreter") as! String, time: newMessage.value(forKey: "time") as! String)
            }
            self.observer?.handleNewChanges(message: message)
        }
    }
    
    deinit {
        if let messageHandle = self.messageHandle {
            messagesReference.removeObserver(withHandle: messageHandle)
        }
    }
}
