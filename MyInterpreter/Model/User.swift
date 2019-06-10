//
//  User.swift
//  MyInterpreter
//
//  Created by Tom on 4/1/19.
//  Copyright © 2019 Tom. All rights reserved.
//

import Foundation


class User
{
    var name: String
    var motherLanguage: String
    var secondLanguage: String
    var email: String
    var profileImageURL: String
    var booking: String
    
    init()
    {
        name = ""
        motherLanguage = ""
        secondLanguage = ""
        email = ""
        profileImageURL = ""
        booking = ""
    }
    
    init(email: String, name: String, motherLanguage: String, secondLanguage: String, profileImageURL: String, booking: String)
    {
        self.email = email
        self.name = name
        self.motherLanguage = motherLanguage
        self.secondLanguage = secondLanguage
        self.profileImageURL = profileImageURL
        self.booking = booking
    }
    
    // MARK: profile image
    func setProfileImageURL(imageURL: String)
    {
        self.profileImageURL = imageURL
    }
    
    // MARK: name
    func setName(name: String)
    {
        self.name = name
    }
    
    // MARK: motherlanguage
    func setMotherLanguage(motherLanguage: String)
    {
        self.motherLanguage = motherLanguage
    }
    
    // MARK: secondlanguage
    func setSecondLanguage(secondLanguage: String)
    {
        self.secondLanguage = secondLanguage
    }
    
    // MARK: Email
    func setEmail(email: String)
    {
        self.email = email
    }
    
    // MARK: Booking status
    func setBooking(booking: String)
    {
        self.booking = booking
    }
}
