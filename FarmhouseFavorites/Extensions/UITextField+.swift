//
//  UITextField+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 12/12/21.
//

import Foundation
import UIKit

enum TextFieldStyles {
    case focus
    case error
    case none
    
    var borderCorlor: CGColor? {
        switch self {
        case .focus: return Styles.Colors.TextFieldFocus?.cgColor
        case .error: return Styles.Colors.ErrorColor?.cgColor
        case .none: return UIColor.black.cgColor
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .focus: fallthrough
        case .error:
            return 2.0
        case .none:
            return 0.0
        }
    }
}

extension UITextField {
    func addDoneCancelToolbar(onDone: (target: Any, action: Selector)? = nil, onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        let onDone = onDone ?? (target: self, action: #selector(doneButtonTapped))

        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        ]
        toolbar.sizeToFit()

        self.inputAccessoryView = toolbar
    }

    func isNilOrEmpty() -> Bool {
        if let text = self.text {
            return text.isEmpty
        }
        return false
    }
    
    func setStyle(_ style: TextFieldStyles) {
        self.layer.borderColor = style.borderCorlor
        self.layer.borderWidth = style.borderWidth
    }
    
    // Default actions:
    @objc func doneButtonTapped() { self.resignFirstResponder() }
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
