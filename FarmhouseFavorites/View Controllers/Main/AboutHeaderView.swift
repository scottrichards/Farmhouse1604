//
//  AboutHeaderView.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 6/16/22.
//

import UIKit

class AboutHeaderView: UITableViewHeaderFooterView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var textBorderView: UIView!
    
    func populate(data: SectionHeaderData) {
        textBorderView.layer.borderColor = Styles.Colors.Border?.cgColor
        textBorderView.layer.borderWidth = 1
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }

}
