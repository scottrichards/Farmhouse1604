//
//  Styles.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 6/16/22.
//

import Foundation
import UIKit

struct Styles {
    struct Colors {
        static let Border = UIColor(hexString: "#4A4A4A")
        static let LinkTextColor = UIColor(hexString: "#0057FF")
        static let ButtonBackgroundColor = UIColor(hexString: "#268D75")
        static let ButtonTextColor = UIColor.white
        static let DisabledBackgroundColor = UIColor(hexString: "#268D75", alpha: 0.3)
        
        
        // For Highlihgting the detected rectangle
        static let HighlightColor = UIColor(hexString: "#FFC701", alpha: 0.6)
        
        static let CallOutViewBackgroundColor = UIColor(hexString: "#f3f8f9")
        
        static let TextFieldFocus = UIColor(hexString: "#99b5f8")
        
        static let ErrorColor = UIColor(hexString: "#ff3a30")
    }
    
    static let CornerRadius: CGFloat = 8
    
    struct SecondaryButton {
        static let Height: CGFloat = 56.0
    }
}
