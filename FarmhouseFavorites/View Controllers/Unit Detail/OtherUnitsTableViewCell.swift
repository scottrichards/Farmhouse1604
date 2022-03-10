//
//  OtherUnitsTableViewCell.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/10/22.
//

import UIKit

class OtherUnitsTableViewCell: UITableViewCell {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func populate(data: UnitDetailData) {
       
    }
    
}
