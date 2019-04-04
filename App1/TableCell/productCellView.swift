//
//  productCellView.swift
//  App1
//
//  Created by Robin on 17/03/2019.
//  Copyright © 2019 Robin. All rights reserved.
//

import UIKit

class productCellView: UITableViewCell {
   
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 

}
