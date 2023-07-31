//
//  TabController.swift
//  ApICaller
//
//  Created by Kavin Jha on 12/07/23.
//

import UIKit
import FirebaseAuth

class TabController: UITabBarController {

    private let mainStoryboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVc = mainStoryboard.instantiateViewController(withIdentifier: "ViewController")
        
        let commentVc = mainStoryboard.instantiateViewController(withIdentifier: "CommentsViewController")
        
        let photoVc = mainStoryboard.instantiateViewController(withIdentifier: "PhotoViewController")
        
        //self.navigationController?.toolbar.largeContentTitle = "A"
        //navigationItem.title = "TabController"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(handleSignOutButtonTapped))
        
        
        self.setViewControllers([homeVc,commentVc,photoVc], animated: true)
        homeVc.title = "Home"
        commentVc.title = "Comments"
        photoVc.title = "Photos"
        let navBarAppearance = UINavigationBarAppearance()
          navBarAppearance.configureWithOpaqueBackground()
          UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        //navigationItem.largeTitleDisplayMode = .always
        let appearance = UINavigationBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           appearance.backgroundColor = .black
           let proxy = UINavigationBar.appearance()
           proxy.tintColor = .white
           proxy.standardAppearance = appearance
           proxy.scrollEdgeAppearance = appearance
        
        navigationItem.title = "News"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "CaviarDreams", size: 20)!]
        navigationController?.navigationBar.tintColor = .black
        tabBar.barTintColor = .white
        guard let items = self.tabBar.items else {return}
        
        let images = ["house","bell", "camera"]
        
        for x in 0...2{
            tabBar.tintColor = .black
            items[x].image = UIImage(systemName: images[x])
        }
        
        
    }
    
    
    @objc func handleSignOutButtonTapped() {
        
        do {
            try Auth.auth().signOut()

            let backNavRoot = self.mainStoryboard.instantiateViewController(withIdentifier: "AuthenticationVc")
            let navController = UINavigationController(rootViewController: backNavRoot)
            //            let backNavRoot = UINavigationController(rootViewController: AuthenticationVc())
            UIApplication.shared.keyWindow?.rootViewController = navController
            
        } catch let err{
            
            print(err)
            
        }
    }
    


}
