//
//  DeetailViewController.swift
//  ApICaller
//
//  Created by Kavin Jha on 07/07/23.
//

import UIKit

class DetailViewController: UIViewController {
    

    var desiredPostBody : String = "fff"
    var desiredPostTitle : String = "fff"
    var desiredPostImage: String = "ffff"
    var desiredPostUrl: String?
    

    @IBOutlet weak var DetailView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        DetailView.estimatedRowHeight = 100
        
        DetailView.register(UINib(nibName: "DetailViewCellTitle", bundle: nil), forCellReuseIdentifier: "DetailViewCellTitle")
        
        DetailView.register(UINib(nibName: "DetailViewCellBody", bundle: nil), forCellReuseIdentifier: "DetailViewCellBody")
        
        DetailView.register(UINib(nibName: "DetailViewCellImage", bundle: nil), forCellReuseIdentifier: "DetailViewCellImage")
        
        DetailView.register(UINib(nibName: "DetailViewCellButton", bundle: nil), forCellReuseIdentifier: "DetailViewCellButton")
        
        DetailView.rowHeight = UITableView.automaticDimension
        DetailView.backgroundColor = .white

        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.addTarget(self, action: #selector(handleShareButtonTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItems = [barButton]
        
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(handleShareButtonTapped))
//
//        let desiredURL = "https://jsonplaceholder.typicode.com/posts/\(desiredPostId)"
//
//        let anonymousFunction = { (fetchedData: Data) in
//
//            guard (try? JSONDecoder().decode(PostData.self, from: fetchedData)) != nil else {
//
//                print("Couldn't decode JSON")
//                return
//            }
//a way to transfer ID from original view controller to Detail view controller and use that as an api caller link
//        }
//
//        APICaller.shared.request(url: URL(string: desiredURL)!, onCompletion: anonymousFunction)
    }

//    func showShareIntent() {
//        let shareSheetVC = UIActivityViewController(activityItems: ["lol"], applicationActivities: nil)
//        self.present(shareSheetVC, animated: true)
//    }
    
    @objc func handleShareButtonTapped(){
        
        
        let shareSheetVC = UIActivityViewController(activityItems: [desiredPostUrl as Any], applicationActivities: nil)
        self.present(shareSheetVC, animated: true)
        
    }
}
    
    extension DetailViewController: UITableViewDelegate,UITableViewDataSource {
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)

        }
        
        func numberOfSections(in : UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            if indexPath.row == 0 {
                let cell : DetailViewCellTitle? = tableView.dequeueReusableCell(withIdentifier: "DetailViewCellTitle") as? DetailViewCellTitle
                
                cell?.titleLabel.text = desiredPostTitle
                
                return cell!
            }
            
            else if indexPath.row == 2 {
                
                let cell: DetailViewCellBody? = tableView.dequeueReusableCell(withIdentifier: "DetailViewCellBody") as? DetailViewCellBody
                
                cell?.bodyLabel.text = desiredPostBody
                
                return cell!
            }

            else if indexPath.row == 1 {

                let cell: DetailViewCellImage? = tableView.dequeueReusableCell(withIdentifier: "DetailViewCellImage") as? DetailViewCellImage
                
              let finalImage = URL(string: desiredPostImage)

                cell?.initialize(finalImage)
                return cell!
            }
            
            else if indexPath.row == 3 {
                
                let cell: DetailViewCellButton? = tableView.dequeueReusableCell(withIdentifier: "DetailViewCellButton") as? DetailViewCellButton
                
                let actualUrl = URL(string: desiredPostUrl!)
                cell?.initialize(actualUrl)
                
                return cell!
            }
            
            else {print("something in table view not working properly")}
            
            return UITableViewCell()
            
        }
        
//        func didSelectShareIntent() {
//            self.handleShareButtonTapped()
//        }
        
    }
    

