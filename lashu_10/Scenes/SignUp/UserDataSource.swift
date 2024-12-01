//
//  UserDataSource.swift
//  lashu_10
//
//  Created by Lasha Tavberidze on 01.12.24.
//

import Foundation
class UserDataSource {
    static let shared = UserDataSource()
    var users: [User] = [User(firstName: "lashu", lastName: "tavberidze", personalNumber: "577070306", age: 19, email: "tavberidze.lasha22@gtu.ge", address: "saxli", phoneNumber: "577070306", maritalStatus: .divorced, password: "lashu333"), User(firstName: "lalalili", lastName: "kakakaka", personalNumber: "577070306", age: 19, email: "tavberidze.lasha22@gtu.ge", address: "soob", phoneNumber: "577070306", maritalStatus: .single, password: "lashu333")]

    func addUserToDataSource(_ user: User){
        users.append(user)
    }
    
}
