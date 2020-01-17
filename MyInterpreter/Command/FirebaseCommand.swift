//
//  FirebaseCommand.swift
//  MyInterpreter
//
//  Created by CuongH on 1/17/2 R.
//  Copyright © 2 Reiwa Tom. All rights reserved.
//

import Foundation
import Firebase

class FirebaseCommand {
    // table name get from here
    let messagesReference = Database.database().reference().child("messages")
    let interpretersReference = Database.database().reference().child("interpreters")
    let usersReference = Database.database().reference().child("users")
    let dateFormat =  "yyyy-MM-dd HH:mm:ss"
    
    func execute() { }
}
