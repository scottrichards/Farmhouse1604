//
//  UnitTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 6/15/22.
//

import UIKit

class UnitTableViewCell: UITableViewCell {

  
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(data: MainTableCellData) {
        quoteLabel.text = data.quote
        titleLabel.text = data.title
        descriptionLabel.text = data.description
        infoLabel.text = data.info
        pictureImageView.image = UIImage(named: data.image)
    }
    
}
