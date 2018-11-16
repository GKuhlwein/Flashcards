//
//  DeckTableViewCell.swift
//  FlashCards
//
//  Created by Tom Kuhlwein on 11/1/18.
//  Copyright © 2018 AirCo. All rights reserved.
//

import UIKit

class DeckTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var deckName: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
