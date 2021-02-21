//
//  TourTableViewCell.swift
//  TouristApp
//
//  Created by Pinal Patel on 2020-11-28.
//

import UIKit

class TourTableViewCell: UITableViewCell {

    @IBOutlet weak var txtPlaceLocation: UILabel!
    @IBOutlet weak var txtplaceName: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    
    @IBOutlet weak var imgWishlist: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
