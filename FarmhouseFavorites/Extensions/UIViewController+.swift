//
//  UIViewController+.swift
//  FavoritesUIKit
//
//  Created by Scott Richards on 4/16/21.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    func displayAlert(_ message: String, title: String = "Error") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}

extension UIViewController {
    /// Display MBProgress HUD
    ///  withTitle: Title at the top
    ///  description: Optional body text
    ///  viewToAddTo: If you want to add it to a particular view instead of the UIViewController view (e.g. iPad)
    ///  mode: either determinate Fixed like progress bar or indeterminate (default) spinner
    func showProgress(withTitle title: String? = "Loading…", and description: String? = nil, viewToAddTo: UIView? = nil, mode: MBProgressHUDMode = .indeterminate, duration: CGFloat? = 0) -> MBProgressHUD {
//        guard let viewToAddTo = self.view.window ?? self.view else { return }
        
        let progress = MBProgressHUD.showAdded(to: viewToAddTo ?? self.view, animated: true)
        progress.label.text = title
        progress.isUserInteractionEnabled = false
        progress.removeFromSuperViewOnHide = true
        progress.mode = mode
        if let description = description {
            progress.detailsLabel.text = description
        }
        progress.show(animated: true)
        if let duration = duration, duration > 0 {
            hideProgress(viewToRemoveFrom: viewToAddTo, after: duration)
        }
        return progress
    }
    
    func hideProgress(viewToRemoveFrom: UIView? = nil, after: CGFloat? = nil) {
        if let seconds = after {
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                MBProgressHUD.hide(for: viewToRemoveFrom ?? self.view, animated: true)
            }
        } else {
            MBProgressHUD.hide(for: viewToRemoveFrom ?? self.view, animated: true)
        }
    }
    
    /// Display an indeterminate spinner call when making network calls
    func showSpinner() {
        let progress = MBProgressHUD.showAdded(to: self.view, animated: true)
        progress.mode = .indeterminate
        progress.show(animated: true)
    }
    
    /// Hide the indeterminate spinner
    func hideSpinner() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
   
}

extension UIViewController {
    
    func add(child: UIViewController?, contentView: UIView? = nil, beforeAdd: (() -> Void)? = nil, afterAddBeforeMove: (() -> Void)? = nil, afterMove: (() -> Void)? = nil) {
        guard let child = child else {
            return
        }
        
        child.willMove(toParent: self)
        beforeAdd?()
        addChild(child)

        if let contentView = contentView ?? self.view {
            contentView.addSubview(child.view)
        }

        afterAddBeforeMove?()
        child.didMove(toParent: self)
        afterMove?()
    }
    
    func remove(child: UIViewController?) {
        guard let child = child else {
            return
        }
        
        child.willMove(toParent: nil)
        child.view.removeFromSuperview()
        child.removeFromParent()
    }
    
}



