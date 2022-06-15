//
//  AreaInfoTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/13/22.
//

import UIKit

class AreaInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var mapImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onOpenMap))
        mapImageView.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func onOpenMap() {
        if let url = URL(string: Constants.Urls.map) {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
    
}
