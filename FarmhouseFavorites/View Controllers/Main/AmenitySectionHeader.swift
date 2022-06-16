//
//  AmenitySectionHeader.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 6/16/22.
//

import UIKit

class AmenitySectionHeader: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    func populate(data: SectionHeaderData) {
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }

}
