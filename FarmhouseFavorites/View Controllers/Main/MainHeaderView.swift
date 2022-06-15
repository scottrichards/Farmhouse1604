//
//  MainHeaderView.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 2/27/22.
//

import UIKit

protocol MainHeaderViewDelegate: AnyObject {
    func onOpenMenu()
}

class MainHeaderView: NibView {
    @IBOutlet weak var menuButton: UIButton!
    weak var delegate: MainHeaderViewDelegate?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onMenu(_ sender: Any) {
    }
}
