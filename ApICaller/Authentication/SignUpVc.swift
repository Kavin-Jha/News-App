//
//  SignUpVc.swift
//  ApICaller
//
//  Created by Kavin Jha on 17/07/23.
//

import UIKit
import Toast
import FirebaseAuth

class SignUpVc: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var signUpButtonProperty: UIButton!
    
    @IBOutlet weak var signUpLabel: UILabel!
    
    
    @IBOutlet weak var emailField: UITextField!
    
    
    @IBOutlet weak var passwordField: UITextField!
    
    
    @IBAction func signUpButton(_ sender: Any) {
        
        view.endEditing(true)
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else{
            
            self.view.makeToast("Please fill in all fields", duration: 3, position: CSToastPositionBottom)
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: {[weak self] result,error in
            
            guard let strongSelf = self else{
                
                return
            }
            guard error == nil else{
                
                self!.view.makeToast("Make sure your email is valid and password is at least 7 characters", duration: 3, position: CSToastPositionBottom)
                return
                
            }
            self!.view.makeToast("you have signed up", duration: 1.5, position: CSToastPositionBottom)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self?.navigationController?.popViewController(animated: true)
            })
            
            
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.emailField.delegate = self
        self.passwordField.delegate = self
        emailField.layer.cornerRadius = 15
        passwordField.layer.cornerRadius = 15
       emailField.layer.borderWidth = 1
       passwordField.layer.borderWidth = 1
        emailField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        signUpButtonProperty.layer.cornerRadius = signUpButtonProperty.frame.height/2
        initializeHideKeyboard()
   
        // Do any additional setup after loading the view.
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        return textField.resignFirstResponder()
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
