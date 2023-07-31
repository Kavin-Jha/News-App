//
//  AuthenticationVc.swift
//  ApICaller
//
//  Created by Kavin Jha on 17/07/23.
//

import UIKit
import FirebaseAuth
import Toast

class AuthenticationVc: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var noAccountLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var buttonProceed: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var buttonSignuo: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signUpButton(_ sender: Any) {
        navigateTo(viewController: "SignUpVc")

    }
    
    @IBAction  func proceedButton(_ sender: Any) {
        
        view.endEditing(true)
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else{
            
            self.view.makeToast("Fields are missing", duration: 2, position: CSToastPositionBottom)
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result,error in
            
            guard let strongSelf = self else{
                print("self is dealocated")
                return
            }
            guard error == nil else{
                
                //show account creation
                self!.view.makeToast("Account doesn't exist. You should Sign up!", duration: 2, position: CSToastPositionBottom)
                return
                
            }
            
            print("you have signed in")
            //self!.navigateTo(viewController: "ViewController")
            let navigationRoot = UINavigationController(rootViewController: TabController())
            
            UIApplication.shared.keyWindow?.rootViewController = navigationRoot
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        print(self.emailField)
        self.emailField.delegate = self
        self.passwordField.delegate = self
        emailField.layer.cornerRadius = 15
        passwordField.layer.cornerRadius = 15
       emailField.layer.borderWidth = 1
       passwordField.layer.borderWidth = 1
        buttonProceed.layer.cornerRadius = buttonProceed.frame.height / 2
        buttonSignuo.layer.cornerRadius = buttonSignuo.frame.height/2
        emailField.attributedPlaceholder = NSAttributedString(
            string: "Email ID",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        initializeHideKeyboard()

    }
    
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         return textField.resignFirstResponder()
    }
    
    func navigateTo (viewController screenName:String){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: screenName)
       
//        self.present(vc, animated: true)
navigationController?.pushViewController(vc, animated: true)
    }
    
    func initializeHideKeyboard(){
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(
     target: self,
     action: #selector(dismissMyKeyboard))
     view.addGestureRecognizer(tap)
     }
    
    @objc func dismissMyKeyboard(){

    view.endEditing(true)
    }
  

}
