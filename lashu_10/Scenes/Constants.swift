//
//  Constants.swift
//  lashu_10
//
//  Created by Lasha Tavberidze on 02.12.24.
//

import UIKit
struct Constants{
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    static func hasEmptyFields(fields: [UITextField?]) -> Bool {
        for field in fields {
            if let text = field?.text, text.isEmpty {
                return true
            }
        }
        return false
    }
    
}
