//
//  AmenitiesTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 6/15/22.
//

import UIKit

class AmenitiesTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(data: AmenitiesData) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        pictureImageView.image = UIImage(named: data.image)
    }
}
