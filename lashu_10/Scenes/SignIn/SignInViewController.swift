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
        guard let email = emailTextField?.text,
              let password = passwordTextField?.text else {
            C.shared.showAlert(vc: self, alert: alert, title: "Empty Fields", message: "Please fill in both email and password.")
            return
        }
        
        if !C.shared.isValidEmail(email) {
            C.shared.showAlert(vc: self, alert: alert, title: "Invalid Email", message: "Please enter a valid email address.")
            return
        }
        
        let (canLogIn, user) = canLogIn()
        if canLogIn, let user = user {
            moveToUserProfile(user: user)
        } else if UserDataSource.shared.users.contains(where: { $0.email == email }) {
            C.shared.showAlert(vc: self, alert: alert, title: "Wrong Password", message: "Your email exists, but the password is incorrect.")
        } else {
            C.shared.showAlert(vc: self, alert: alert, title: "User Not Found", message: "No user found with the provided email.")
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
        guard let email = emailTextField?.text else { return false }
        if !C.shared.isValidEmail(email) { return false }
        return UserDataSource.shared.users.contains { $0.email == email }
    }
    func doesUserExist() -> (Bool, User?) {
        guard let email = emailTextField?.text else { return (false, nil) }
        if let user = UserDataSource.shared.users.first(where: { $0.email == email }) {
            return (true, user)
        }
        return (false, nil)
    }
    func canLogIn() -> (Bool, User?) {
        guard let email = emailTextField?.text,
              let password = passwordTextField?.text else { return (false, nil) }
        if let user = UserDataSource.shared.users.first(where: { $0.email == email }) {
            return (user.password == password, user)
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
