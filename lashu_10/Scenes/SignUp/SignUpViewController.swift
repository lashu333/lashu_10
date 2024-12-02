//
//  SignUpViewController.swift
//  lashu_10
//
//  Created by Lasha Tavberidze on 01.12.24.
//

import UIKit

class SignUpViewController: UIViewController {
    //MARK: Outlets
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var personalNumberTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var maritalStatusTextField: UITextField!
    @IBOutlet weak var workPlaceTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    //MARK: Properties
    //let user: User?
    let toolBar = Constants.shared.toolBar
    let alert = UIAlertController()
    let nextButton = UIBarButtonItem(title: "next", style: .plain, target: nil, action: #selector(nextButtonTapped))
    let doneButton = UIBarButtonItem(title: "done", style: .plain, target: nil, action: #selector(doneButtonTapped))
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let textFields = [
            firstNameTextField, lastNameTextField, personalNumberTextField,
            ageTextField, phoneNumberTextField, emailTextField,
            addressTextField, maritalStatusTextField, workPlaceTextField,
            passwordTextField
        ]
        Constants.shared.setUpToolBar([nextButton, doneButton], textFields, toolBar, self)
        setUpDummyFields()
        setUpAlert()
    }
    
    //MARK: Actions
    @IBAction func didTapRegisterButton(_ sender: UIButton) {
        var couldFoundUserInSource: Bool = false
        let maritalStatus = User.getMaritalStatus(maritalStatusTextField?.text ?? "")
        guard let firstName = firstNameTextField?.text, !firstName.isEmpty,
              let lastName = lastNameTextField?.text, !lastName.isEmpty,
              let personalNumber = personalNumberTextField?.text, !personalNumber.isEmpty,
              let ageText = ageTextField?.text, let age = Int(ageText), age > 0,
              let phoneNumber = phoneNumberTextField?.text, !phoneNumber.isEmpty,
              let email = emailTextField?.text, isValidEmail(email),
              let address = addressTextField?.text, !address.isEmpty,
              let workPlace = workPlaceTextField?.text, !workPlace.isEmpty,
              let password = passwordTextField?.text else {
            
            Constants.shared.showAlert(alert: alert, title: "empty fields!", message: "Please fill all fields correctly")
            return
        }
        let newUser = User(
            firstName: firstName,
            lastName: lastName,
            personalNumber: personalNumber,
            age: age,
            email: email,
            address: address,
            phoneNumber: phoneNumber,
            maritalStatus: maritalStatus,
            workPlace: workPlace,
            password: password
        )
        for u in UserDataSource.shared.users {
            if u.email == newUser.email {
                Constants.shared.showAlert(alert: alert,title:"user is already registered ", message: "you can log in")
                couldFoundUserInSource = true
                break
            }
        }
        if couldFoundUserInSource { return }
        registerUser(newUser)
        moveToSignInStoryBoard()
    }
    @IBAction func didEndEditingEmail(_ sender: UITextField) {
        if !isValidEmail(sender.text!){
            emailTextField.layer.borderWidth = 4
            emailTextField.layer.borderColor = UIColor.red.cgColor
        } else{
            emailTextField.layer.borderWidth = 3
            emailTextField.layer.borderColor = UIColor.green.cgColor
        }
    }
    //MARK: Private methods
    private func setUpAlert(){
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func registerUser(_ user: User){
        UserDataSource.shared.addUserToDataSource(user)
        print("registered user \(user)")
    }
    func showAlert(title: String, message: String) {
        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
    }
    func moveToSignInStoryBoard(){
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SignInViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: objc functions for my toolbar
    @objc func doneButtonTapped(){
        view.endEditing(true)
    }
    @objc func nextButtonTapped() {
        let textFields = [
            firstNameTextField, lastNameTextField, personalNumberTextField,
            ageTextField, phoneNumberTextField, emailTextField,
            addressTextField, maritalStatusTextField, workPlaceTextField,
            passwordTextField
        ]
        for (index, textField) in textFields.enumerated() {
            if textField?.isFirstResponder == true, index < textFields.count - 1 {
                textFields[index + 1]?.becomeFirstResponder()
                break
            }
            if textFields.count - 1 == index {
                textFields[0]?.becomeFirstResponder()
            }
        }
    }
}
extension SignUpViewController {
    //MARK: Dummy fields
    private func setUpDummyFields(){
        firstNameTextField.text = "John"
        lastNameTextField.text = "Doe"
        personalNumberTextField.text = "123456789"
        ageTextField.text = "20"
        phoneNumberTextField.text = "123456789"
        emailTextField.text = "john@doe.com"
        addressTextField.text = "1234 Main Street"
        maritalStatusTextField.text = "Single"
        workPlaceTextField.text = "Apple Inc."
        passwordTextField.text = "password"
    }
}
//TO DO : marital status fix, set up tool bar menu for text fields.
//CHECK: es gavakete,,,,,,,,, esec kinda

