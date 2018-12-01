//
//  ItemTableViewCell.swift
//  thrifty
//
//  Created by Charlyn Manuyag on 11/30/18.
//  Copyright © 2018 Kevin Wang. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    @IBOutlet weak var notesLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
