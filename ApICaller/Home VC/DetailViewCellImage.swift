//
//  DetailViewCellShareButton.swift
//  ApICaller
//
//  Created by Kavin Jha on 10/07/23.
//

import UIKit

class DetailViewCellImage: UITableViewCell {
    
    
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialize(_ imageURL: URL?) {
        //TODO: Download URL
        DispatchQueue.main.async {
            
            if let imageURL = imageURL, let data = try? Data(contentsOf: imageURL) {
                self.newsImage.image = UIImage(data: data)
            }
        }
    }
    
}
