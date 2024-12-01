//
//  SignInViewController.swift
//  lashu_10
//
//  Created by Lasha Tavberidze on 02.12.24.
//

import UIKit

class SignInViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //MARK: Properties
    let alert = UIAlertController()
    let toolBar = Constants.shared.toolBar
    let nextButton = UIBarButtonItem(title: "next", style: .plain, target: nil, action: #selector(nextButtonTapped))
    let doneButton = UIBarButtonItem(title: "done", style: .plain, target: nil, action: #selector(doneButtonTapped))
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Constants.shared.setUpToolBar([nextButton,doneButton], [emailTextField, passwordTextField], toolBar, self)
    }
    //MARK: Actions
    @IBAction func didTapLogIn(_ sender: UIButton) {
        if !isEmailValid(){
            Constants.shared.showAlert(vc: self, alert: alert,title: "enter valid email", message: "This is not an email")
            return
        }
        if Constants.shared.hasEmptyFields(fields: [emailTextField, passwordTextField]) {
            Constants.shared.showAlert(vc: self, alert: alert, title: "empty fields", message: "fill the empty fields to log in")
            return
        }
        if canLogIn() {
            
        }
    }
    @IBAction func didEndEditingEmail(_ sender: UITextField) {
        if !isEmailValid() {
            emailTextField.layer.borderWidth = 4
            emailTextField.layer.borderColor = UIColor.red.cgColor
        }else{
            emailTextField.layer.borderWidth = 3
            emailTextField.layer.borderColor = UIColor.green.cgColor
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    //MARK: Methods
    func isEmailValid() -> Bool {
        Constants.shared.isValidEmail(emailTextField?.text ?? "")
    }
    func doesUserExist() -> (Bool, User?) {
        guard let email = emailTextField?.text else {
                return (false, nil)
            }
            if let user = UserDataSource.shared.users.first(where: { $0.email == email }) {
                return (true, user)
            }
            return (false, nil)
    }
    func canLogIn() -> Bool{
        let (isValid, user) = doesUserExist()
        if isValid {
            guard let password = passwordTextField?.text else {
                return false
            }
            if user?.password == password {
               return true
            }
        }
        return false
    }
    //MARK: objc funcs
    @objc func doneButtonTapped(){
        view.endEditing(true)
    }
    @objc func nextButtonTapped(){
        if emailTextField?.isFirstResponder == true {
            passwordTextField?.becomeFirstResponder()
        } else{
            if passwordTextField?.isFirstResponder == true {
                emailTextField?.becomeFirstResponder()
            }
        }
        
    }
}
