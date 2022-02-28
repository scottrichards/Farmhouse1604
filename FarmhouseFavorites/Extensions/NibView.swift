//
//  NibView.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 2/28/22.
//

import Foundation
import UIKit


/// Simple base class replacement for UIView that standardizes the loading of a view from a nib,
/// whether it is created within another nib or in code via a zeroed frame.
///
/// Helps to avoid simple mistakes in setting up this code manually for many views.
class NibView: UIView {
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        
        commonInit()
        awakeFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        loadOwnedNib()
    }
}

