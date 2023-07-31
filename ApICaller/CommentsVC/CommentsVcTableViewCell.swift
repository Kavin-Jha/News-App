//
//  CommentsVcTableViewCell.swift
//  ApICaller
//
//  Created by Kavin Jha on 13/07/23.
//

import UIKit

class CommentsVcTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initialize(_ name: String?, body: String?) {
        self.titleLabel.text = name
        self.subtitleLabel.text = body
    }
    
}
