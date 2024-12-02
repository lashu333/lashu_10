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
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpAlert()
        // Do any additional setup after loading the view.
    }
    //MARK: Actions
    @IBAction func didTapLogIn(_ sender: UIButton) {
        if !isEmailValid(){
            showAlert(title: "enter valid email", message: "This is not an email")
        }
        doesUserExist() ? print("user exists") : print("user doesn't exist")
        if Constants.hasEmptyFields(fields: [emailTextField, passwordTextField]) {
            showAlert(title: "empty fields", message: "fill the empty fields to log in")
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
        Constants.isValidEmail(emailTextField?.text ?? "")
    }
    func showAlert(title: String, message: String) {
        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
    }
    func setUpAlert() {
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    func doesUserExist() -> Bool {
        UserDataSource.shared.users.contains(where: { $0.email == emailTextField?.text ?? "" })
    }
    
}
