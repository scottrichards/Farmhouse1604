//
//  UIStackView+.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/6/22.
//

import Foundation
import UIKit

extension UIStackView {
    /**
     Remove arranged subviews both from the stack view's arrangedSubviews array and from its subviews collection.
     - parameter type: The type of the subviews to be removed. If nil, then all subviews are removed. Defaults to nil.
     */
    func removeAllArrangedSubviews<T: UIView>(ofType type: T.Type? = nil) {
        for subview in self.arrangedSubviews {
            if let type = type {
                if Swift.type(of: subview) == type {
                    removeArrangedSubview(subview)
                    subview.removeFromSuperview()
                }
            } else {
                removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
        }
    }

    func removeCustomSpacing() {
        for views in self.arrangedSubviews {
            setCustomSpacing(0.0, after: views)
        }
    }
}
