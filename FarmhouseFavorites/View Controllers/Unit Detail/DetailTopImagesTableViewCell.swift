//
//  DetailTopImagesTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/3/22.
//

import UIKit

class DetailTopImagesTableViewCell: UITableViewCell {
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(data: UnitDetailData) {
        firstImageView.image = UIImage(named: data.topImages[0].url)
        secondImageView.image = UIImage(named: data.topImages[1].url)
    }
    
}
