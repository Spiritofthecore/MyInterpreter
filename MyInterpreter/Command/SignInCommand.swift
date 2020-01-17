//
//  SignInCommand.swift
//  MyInterpreter
//
//  Created by CuongH on 1/17/2 R.
//  Copyright © 2 Reiwa Tom. All rights reserved.
//

import Foundation
import Firebase

protocol SignInDoneDelegate {
    func handleResult(error: Error?, isBooking: Bool)
}

class SignInCommand: FirebaseCommand {
    let email: String
    let password: String
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    var delegate: SignInDoneDelegate?
    override func execute() {
        Auth.auth().signIn(withEmail: email, password: password) { (user: AuthDataResult?, error: Error?) in
            if user != nil
            {
                let bookingInterpreter = self.usersReference.child(self.email.getEncodedEmail()).child("booking")
                bookingInterpreter.observeSingleEvent(of: .value) { (snapshot: DataSnapshot) in
                    let bookingObject = snapshot.value as! String
                    if bookingObject.contains("interpreter0")
                    {
                        self.delegate?.handleResult(error: nil, isBooking: false)
                    }
                    else
                    {
                        self.delegate?.handleResult(error: nil, isBooking: true)
                    }
                }
            }
            else
            {
                self.delegate?.handleResult(error: error, isBooking: false)
            }
        }
    }
}
