//
//  DetailInfoTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/6/22.
//

import UIKit

class DetailInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var inquireButton: UIButton!
    var data: UnitDetailData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let data = data {
            populate(data: data)
        }
        inquireButton.layer.borderWidth = 1
        inquireButton.layer.borderColor = UIColor.lightGray.cgColor
        inquireButton.layer.cornerRadius = 10.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(data: UnitDetailData) {
        bodyLabel.text = data.info
    }
    
}
