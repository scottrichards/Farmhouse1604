//
//  MenuHeaderView.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 6/25/22.
//

import UIKit

protocol MenuHeaderViewDelegate: AnyObject {
    func onGoBackToMain()
}

class MenuHeaderView: UITableViewHeaderFooterView {
    weak var delegate: MenuHeaderViewDelegate?
    
    @IBAction func goBack(_ sender: Any) {
        print("on go back")
        delegate?.onGoBackToMain()
    }
}
