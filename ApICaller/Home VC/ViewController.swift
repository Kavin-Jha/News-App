//
//  ViewController.swift
//  ApICaller
//
//  Created by Kavin Jha on 06/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var TableView: UITableView!
    
    public var data: NewsApiResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.view)
        TableView.estimatedRowHeight = 80
        
        TableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        
        TableView.rowHeight = UITableView.automaticDimension
        TableView.backgroundColor = .white
        let anonymousFunction = { (fetchedData: Data) in

            guard let userData = try? JSONDecoder().decode(NewsApiResponse.self, from: fetchedData) else {
                print(self.data)
                print("Couldn't decode JSON")
                return
            }
            
            self.data = userData
            self.TableView.reloadData()
        }
        
        APICaller.shared.request(url: URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=7426eeff94d548c3a6940813319d71db")!, onCompletion: anonymousFunction)
    }
    
    func navigateTo (viewController screenName:String){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: screenName)
        navigationController?.pushViewController(vc, animated: true)
    }
}
    extension ViewController: UITableViewDelegate,UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return data?.articles.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell : TableViewCell? = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as? TableViewCell
            
          //  print(data[indexPath.row])
        
            cell?.titleLabel.text = data?.articles[indexPath.row].title
            
            let source = data?.articles[indexPath.row].publishedAt
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let result = dateFormatter.date(from: source!)
            
            dateFormatter.dateFormat = "MMM d, h:mm a"
            let str = dateFormatter.string(from: result!)
            
            cell?.subtitleLabel.text = str
            
            return cell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            
            
            tableView.deselectRow(at: indexPath, animated: true)

            let postData = self.data?.articles[indexPath.row]
            let desiredImage = postData?.urlToImage
            let desiredBody = postData?.content
            let desiredTitle = postData?.title
            let desiredUrl = postData?.url

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController

            vc?.desiredPostImage = desiredImage!
            vc?.desiredPostTitle = desiredTitle!
            vc?.desiredPostBody = desiredBody!
            vc?.desiredPostUrl = desiredUrl!

            navigationController?.pushViewController(vc!, animated: true)

            //navigateTo(viewController: "DetailViewController")
        }
        
    }

