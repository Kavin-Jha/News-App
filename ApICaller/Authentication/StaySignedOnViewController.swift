//
//  StaySignedOnViewController.swift
//  ApICaller
//
//  Created by Kavin Jha on 18/07/23.
//

import UIKit
import Firebase

class StaySignedOnViewController: UIViewController {
    
    private let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticateUserAndConfigureView()
    }
    
    func authenticateUserAndConfigureView(){
        
        if Auth.auth().currentUser == nil{
            
            let navController = self.mainStoryboard.instantiateViewController(withIdentifier: "AuthenticationVc")
            let navigationController = UINavigationController(rootViewController: navController)
            //                self.present(navController, animated: true)
            
            UIApplication.shared.keyWindow?.rootViewController = navigationController
            
        }
        
        
        else {
            
            let nav = UINavigationController(rootViewController: TabController())
            UIApplication.shared
                .keyWindow?.rootViewController = nav
            
        }
        
        
    }
    
    
}
