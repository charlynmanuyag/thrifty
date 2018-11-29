//
//  CategoryTableViewCell.swift
//  thrifty
//
//  Created by Charlyn Manuyag on 11/28/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var CategoryLogo: UIImageView!
    
    @IBOutlet weak var CategoryLabel: UILabel!
    
    @IBOutlet weak var AmountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
