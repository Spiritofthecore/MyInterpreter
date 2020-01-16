//
//  FirebaseObserver.swift
//  MyInterpreter
//
//  Created by HoangCuong on 1/15/20.
//  Copyright © 2020 Tom. All rights reserved.
//

import Foundation
import Firebase

protocol FirebaseObserverDelegation {
    func addMessage(message: Message)
}
protocol FirebaseObserverInterpreter {
    func getInterpreterInfo(interpreter: Interpreter)
}

class FirebaseHandler {
    var delegate: FirebaseObserverDelegation?
    var delegate2: FirebaseObserverInterpreter?
    func addMessageObserver(for userId: String, interpreterEmail: String) {
        Database.database().reference().child("messages").queryOrdered(byChild: "user").queryEqual(toValue: userId).observe(.childAdded) { (snapshot) in
            
            guard let newMessage = snapshot.value as? NSDictionary else {
                return
            }
            var encodedEmail = interpreterEmail.getEncodedEmail()
            if (Auth.auth().currentUser?.email?.contains("interpreter"))! {
                encodedEmail = (Auth.auth().currentUser?.email?.getEncodedEmail())!
            }
            if (newMessage.value(forKey: "interpreter") as? String == encodedEmail) {
                if (newMessage.value(forKey: "image") != nil) {
                    let message = Message(sender: newMessage.value(forKey: "sender") as! String, imageURL: newMessage.value(forKey: "image") as! String, user: newMessage.value(forKey: "user") as! String, interpreter: newMessage.value(forKey: "interpreter") as! String, time: newMessage.value(forKey: "time") as! String)
                    self.delegate?.addMessage(message: message)
                } else if (newMessage.value(forKey: "text") != nil) {
                    let message = Message(sender: newMessage.value(forKey: "sender") as! String, text: newMessage.value(forKey: "text") as! String, user: newMessage.value(forKey: "user") as! String, interpreter: newMessage.value(forKey: "interpreter") as! String, time: newMessage.value(forKey: "time") as! String)
                    self.delegate?.addMessage(message: message)
                } else if (newMessage.value(forKey: "video") != nil) {
                    let message = Message(sender: newMessage.value(forKey: "sender") as! String, videoURL: newMessage.value(forKey: "video") as! String, user: newMessage.value(forKey: "user") as! String, interpreter: newMessage.value(forKey: "interpreter") as! String, time: newMessage.value(forKey: "time") as! String)
                    self.delegate?.addMessage(message: message)
                }
            }
        }
    }
    
    func getInterpreterInfo(id: String) {
        let interpreterRef = Database.database().reference().child("interpreters").child(id)
        
        interpreterRef.observeSingleEvent(of: .value) { (snapshot) in
            let interpreterDic = snapshot.value as! NSDictionary
            self.delegate2?.getInterpreterInfo(interpreter: Interpreter(dic: interpreterDic))
        }
    }
    
    func getNewMessageImageStorageReference(userId: String, interpreterId: String) -> StorageReference {
        let stringDate = self.getDateFormat()
        let fileName = userId + interpreterId + stringDate + ".png"
        return Storage.storage().reference().child("message_images").child(fileName)
    }
    
    func getMessageReference() -> DatabaseReference {
        return Database.database().reference().child("messages").childByAutoId()
    }
    func getDateFormat() -> String {
        return Date().getString(with: "yyyy-MM-dd HH:mm:ss")
    }
    func sendImageMessage(sender: String, imageURL: String, userId: String, interpreterId: String) {
        let stringDate = self.getDateFormat()
        let messageRef = self.getMessageReference()
        messageRef.updateChildValues(["sender": sender, "image": imageURL, "user": userId, "interpreter": interpreterId, "time": stringDate])
    }
    func sendTextMessage(sender: String, text: String, userId: String, interpreterId: String) {
        let stringDate = self.getDateFormat()
        let messageRef = self.getMessageReference()
        messageRef.updateChildValues(["sender": sender, "text": text, "user": userId, "interpreter": interpreterId, "time": stringDate])
    }
}
