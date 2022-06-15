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
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func onMenu(_ sender: Any) {
    }
}
