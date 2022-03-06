//
//  DetailTopImagesTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/3/22.
//

import UIKit

class DetailHeaderTableViewCell: UITableViewCell {
    @IBOutlet weak var unitImageView: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var data: UnitDetailData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        borderView.layer.borderColor = UIColor.lightGray.cgColor
        borderView.layer.borderWidth = 1.0
        if let data = data {
            populate(data: data)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(data: UnitDetailData) {
        titleLabel.text = data.header.title
        headlineLabel.text = data.header.headline
        descriptionLabel.text = data.header.description
        unitImageView.image = UIImage(named:data.header.image)
    }
    
}
