//
//  DetailViewCellButton.swift
//  ApICaller
//
//  Created by Kavin Jha on 21/07/23.

import UIKit

class DetailViewCellButton: UITableViewCell {
    
    
    @IBOutlet weak var buttonForWeb: UIButton!
    
    var actionURL: URL?
    
    @IBAction func jumpToArticleButton(_ sender: Any) {
        
        if let url = self.actionURL {
            
            //TODO: Safari View Controller- SFViewController Load
            UIApplication.shared.open(url)
        }
        
    }
    
    func initialize(_ postURL: URL?) {
        self.actionURL = postURL
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
