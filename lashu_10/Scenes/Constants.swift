//
//  Constants.swift
//  lashu_10
//
//  Created by Lasha Tavberidze on 02.12.24.
//

import UIKit
class Constants{
    static let shared = Constants()
    let toolBar = UIToolbar()
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func hasEmptyFields(fields: [UITextField?]) -> Bool {
        for field in fields {
            if let text = field?.text, text.isEmpty {
                return true
            }
        }
        return false
    }
    func setUpToolBar(_ tbi: [UIBarButtonItem], _ tf: [UITextField?], _ tb: UIToolbar,_ target: AnyObject?){
        tbi.forEach { $0.target = target }
        tb.sizeToFit()
        tb.items = tbi
        tf.forEach { $0?.inputAccessoryView = tb }
    }
    func showAlert(vc: UIViewController,alert:UIAlertController,title: String, message: String){
        if !alert.hasActions{
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        }
        alert.title = title
        alert.message = message
        if vc.presentedViewController != alert {
            vc.present(alert, animated: true, completion: nil)
        }
    }
}
