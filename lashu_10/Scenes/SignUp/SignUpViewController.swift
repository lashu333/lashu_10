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
    let alert = UIAlertController()
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            
            showAlert(title: "empty fields!", message: "Please fill all fields correctly")
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
                showAlert(title:"user is already registered ", message: "you can log in")
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
    func moveToSignInStoryBoard(){
        let sb = UIStoryboard(name: "SignIn", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SignInViewController")
        navigationController?.pushViewController(vc, animated: true)
    }
}

//TO DO : marital status fix, set up tool bar menu for text fields.
//CHECK: es gavakete,,,,,,,,,
