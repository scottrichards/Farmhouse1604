//
//  ScrollingTableHeaderView.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 6/15/22.
//

import UIKit

protocol ScrollingTableHeaderDelegate: AnyObject {
    func onOpenMenu()
}

class ScrollingTableHeaderView: UIView {
    weak var delegate: ScrollingTableHeaderDelegate?

    @IBAction func onOpenMenu(_ sender: Any) {
        delegate?.onOpenMenu()
    }
    
}
