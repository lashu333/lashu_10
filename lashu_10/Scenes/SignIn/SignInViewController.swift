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
    let toolBar = C.shared.toolBar
    let nextButton = UIBarButtonItem(title: "next", style: .plain, target: nil, action: #selector(nextButtonTapped))
    let doneButton = UIBarButtonItem(title: "done", style: .plain, target: nil, action: #selector(doneButtonTapped))
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        C.shared.setUpToolBar([nextButton,doneButton], [emailTextField, passwordTextField], toolBar, self)
    }
    //MARK: Actions
    @IBAction func didTapLogIn(_ sender: UIButton) {
        if !isEmailValid(){
            C.shared.showAlert(vc: self, alert: alert,title: "enter valid email", message: "This is not an email")
            return
        }
        if C.shared.hasEmptyFields(fields: [emailTextField, passwordTextField]) {
            C.shared.showAlert(vc: self, alert: alert, title: "empty fields", message: "fill the empty fields to log in")
            return
        }
        
        let (canLogIn, user) = canLogIn()
        if canLogIn{
            moveToUserProfile(user: user)
        }else{
            C.shared.showAlert(vc: self, alert: alert, title: "wrong password", message: "Your user exists but, you entered wrong password.")
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
    func moveToUserProfile(user: User?){
        let sb = UIStoryboard(name: "UserLoggedIn", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: "UserProfile") as? UserLoggedInViewController{
            vc.user = user
            navigationController?.pushViewController(vc , animated: true)
        }
        
    }
    func isEmailValid() -> Bool {
        C.shared.isValidEmail(emailTextField?.text ?? "")
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
    func canLogIn() -> (Bool, User?){
        let (isValid, user) = doesUserExist()
        if isValid {
            guard let password = passwordTextField?.text else {
                return (false, nil)
            }
            if user?.password == password {
               return (true, user)
            }
        }
        return (false, nil)
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
