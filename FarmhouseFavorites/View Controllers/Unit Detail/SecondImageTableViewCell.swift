//
//  SecondImageTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/10/22.
//

import UIKit

class SecondImageTableViewCell: UITableViewCell {
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapRecognizer = UITapGestureRecognizer(target: imageView1, action: #selector(onSelectedView(_:)))
        self.imageView1.addGestureRecognizer(tapRecognizer)
        self.selectionStyle = .none

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populate(data: UnitDetailData) {
        imageView1.image = UIImage(named: data.bottomImages[0].url)
        imageView2.image = UIImage(named: data.bottomImages[1].url)
        imageView3.image = UIImage(named: data.bottomImages[2].url)
        imageView4.image = UIImage(named: data.bottomImages[3].url)
    }
    
    @objc func onSelectedView(_ sender: UIButton) {
            print("Selected Image 1")
    }
}
