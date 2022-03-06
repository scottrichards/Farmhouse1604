//
//  BottomImagesTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/6/22.
//

import UIKit

class BottomImagesTableViewCell: UITableViewCell {
    @IBOutlet weak var stackView: UIStackView!
    var data: UnitDetailData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        guard let data = data else {
            return
        }
       populate(data: data)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(data: UnitDetailData) {
        for image in data.bottomImages {
            print("adding image: \(image.url)")
            if let image = UIImage(named: image.url) {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFill
                stackView.addArrangedSubview(imageView)
            }
        }
    }
}
