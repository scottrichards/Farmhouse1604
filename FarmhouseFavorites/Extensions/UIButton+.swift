//
//  UIButton+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 12/12/21.
//

import Foundation
import UIKit

enum TruHuButtonStyle {
    case Primary
    case SecondaryMedium
    case LinkPrimary
    case LinkSecondary
}

extension UIButton {
    
    func setStyle(_ style: TruHuButtonStyle) {
        switch style {
        case .Primary:
            self.titleLabel?.font = UIFont(name: "Lato Bold", size: 20)
        case .SecondaryMedium:
            // This bold font does not appear to be working.
            if let font = UIFont(name: "Lato Bold", size: 18) {
                self.titleLabel?.font = font
            }
            self.tintColor = Styles.Colors.ButtonBackgroundColor    // I have a Custom Button in Storyboard with Style set to plain not sure why background is not working I need to set tint Color instead
            self.layer.backgroundColor = Styles.Colors.ButtonBackgroundColor?.cgColor
            self.layer.cornerRadius = Styles.CornerRadius
            self.layer.borderColor = UIColor.white.cgColor
            self.layer.borderWidth = 2
        case .LinkPrimary:
            self.titleLabel?.font = UIFont(name: "Lato", size: 18)
        case .LinkSecondary:
            let uiFont = UIFont(name: "Lato Bold", size: 16)
            self.titleLabel?.font = uiFont
            self.setTitleColor(Styles.Colors.LinkTextColor, for: .normal)
        }
    }
}
