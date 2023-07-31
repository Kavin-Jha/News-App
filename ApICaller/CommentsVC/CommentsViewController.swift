//
//  CommentsViewController.swift
//  ApICaller
//
//  Created by Kavin Jha on 12/07/23.
//

import UIKit

class CommentsViewController: UIViewController {
    
    var data = [CommentsData]()
    
    @IBOutlet weak var commentsTableView: UITableView!
    
    override func viewDidLoad() {
        
        commentsTableView.estimatedRowHeight = 200
        commentsTableView.rowHeight = UITableView.automaticDimension
        commentsTableView.register(UINib(nibName: "CommentsVcTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsVcTableViewCell")
        commentsTableView.backgroundColor = .white
        
        let anonymousFunction = { (fetchedData: Data) in
            
            guard let userData = try? JSONDecoder().decode([CommentsData].self, from: fetchedData) else {
                
                print("Couldn't decode JSON")
                return
            }
            
            self.data = userData
            self.commentsTableView.reloadData()
        }
        
        APICaller.shared.request(url: URL(string: "https://jsonplaceholder.typicode.com/comments")!, onCompletion: anonymousFunction)
    }
}

extension CommentsViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: CommentsVcTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CommentsVcTableViewCell") as! CommentsVcTableViewCell
        
        //TODO: Remove this
        cell = (Bundle.main.loadNibNamed("CommentsVcTableViewCell", owner: self)?.first as? CommentsVcTableViewCell)!
        
        cell.initialize(data[indexPath.row].name, body: data[indexPath.row].body)
        
        return cell
    }
}







