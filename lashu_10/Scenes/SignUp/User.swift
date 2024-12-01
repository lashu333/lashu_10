//
//  User.swift
//  lashu_10
//
//  Created by Lasha Tavberidze on 01.12.24.
//

import Foundation

struct User{
    var firstName: String
    var lastName: String
    var personalNumber: String
    var age: Int
    var email: String
    var address: String
    var phoneNumber: String
    var maritalStatus: MaritalStatus?
    var workPlace: String?
    var password: String
    
    enum MaritalStatus{
        case single
        case married
        case divorced
    }
    init(firstName: String, lastName: String, personalNumber: String, age: Int, email: String, address: String, phoneNumber: String, maritalStatus: MaritalStatus, workPlace: String? = nil, password: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.personalNumber = personalNumber
        self.age = age
        self.email = email
        self.address = address
        self.phoneNumber = phoneNumber
        self.maritalStatus = maritalStatus
        self.workPlace = workPlace
        self.password = password
    }
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.email == rhs.email && lhs.password == rhs.password
    }
   static func userExists(_ user: User) -> Bool{
        var userYes: Bool = false
        for userInSource in UserDataSource.shared.users{
            if user == userInSource {
                userYes = true
            } else {
               userYes = false
            }
        }
        return userYes
    }
}

