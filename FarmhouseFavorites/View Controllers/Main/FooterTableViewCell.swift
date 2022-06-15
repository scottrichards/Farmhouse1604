//
//  FooterTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/10/22.
//

import UIKit

class FooterTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onSendEmail(_ sender: Any) {
        if let url = URL(string: "mailto:\(Constants.email.info)") {
          if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
          } else {
            UIApplication.shared.openURL(url)
          }
        }
    }
}
