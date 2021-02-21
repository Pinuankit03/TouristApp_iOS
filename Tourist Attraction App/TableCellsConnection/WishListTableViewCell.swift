//
//  WishListTableViewCell.swift
//  TouristApp
//
//  Created by Pinal Patel on 2020-11-30.
//

import UIKit

class WishListTableViewCell: UITableViewCell {

  
    @IBOutlet weak var placeimage: UIImageView!
    
    @IBOutlet weak var txtPlaceName: UILabel!
    
    @IBOutlet weak var txtPlaceAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
