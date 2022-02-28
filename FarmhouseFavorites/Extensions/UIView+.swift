//
//  UIView+.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 2/28/22.
//

import Foundation
import UIKit

// MARK: - Code clarity

extension UIView {
    /**
     Simple way to determine whether a view has been loaded and set up within the view hierarchy.
     */
    func isInHierarchy() -> Bool {
        return self.window != nil
    }
    
    /**
     Simple way to determine whether a view type is part of the view hierarchy.
     */
    func ancestor<T: UIView>(ofType type: T.Type) -> T? {
        var currentView = self.superview
        
        while currentView != nil {
            if let typedView = currentView as? T {
                return typedView
            }
            
            currentView = currentView?.superview
        }
        
        return nil
    }
}

// MARK: - Nib loading

extension UIView {
    // TODO: Work on this comment. It's confusing. Though, this is hard to explain.
    /**
     This is a helper function for one conventional way of setting up and loading views from nibs.

     Loads a nib for which this view's class is the "File Owner" and sets that nib's view
     to span the entire bounds of this view as a subview.
     
     If this view overrides both init(frame:) and init(coder:) to call this function, and a nib as described
     above is available, then this provides support for loading a view either programmatically from a nib
     via init(frame:) or automatically for a subview of this type specified in another nib via cascading calls
     to init(coder:) for all views in the other nib.
    
     - parameter name: Optional. The name of the nib to load. If left `nil`, a nib is loaded that has the same filename as this view's class name.
     */
    func loadOwnedNib(withName name: String? = nil) {
        // Use either the name given or assume the nib has the same name as this view's class name.
        let nibName = name ?? self.shortClassName()
        
        // Load the nib
        guard let objects = Bundle.main.loadNibNamed(nibName, owner: self, options: nil) else {
//            GDLog.error("FAILURE: The nib named '\(nibName)' could not be loaded.")
            return
        }
        
        // Find the first top level view. Usually, there will be only one top level object and it will be a view.
        let view = objects.filter({ $0 is UIView }).first as? UIView
        
        // If a top level view was found among the nib's objects,
        // place it inside this view with constraints to make it take up the entire bounds of this view.
        if let baseView = view {
            addSubview(baseView)
            
            baseView.translatesAutoresizingMaskIntoConstraints = false
            translatesAutoresizingMaskIntoConstraints = false
            
            let views = ["baseView": baseView]
            var constraints: [NSLayoutConstraint] = []
            
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "H:|[baseView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
            constraints.append(contentsOf: NSLayoutConstraint.constraints(withVisualFormat: "V:|[baseView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views))
            
            addConstraints(constraints)
        }
    }
    
    /**
     Create a view from a nib.
     
     Instantiates the first top level view object in the nib that matches the calling class' type.
     
     - parameter name: Optional. The name of the nib the view should be loaded from. If nil, the nib filename is assumed to be equal to
     the name of the class calling the function.
     - parameter owner: Optional. Used when loading the nib to specify the nib's owner, which allows for the setup of outlet properties.
     - parameter options: Optional. A dictionary containing the options to use when opening the nib file. For a list of available keys for this dictionary, see Nib File Loading Options.
     
     - returns: A view of the calling type or nil if the view could not be loaded.
     */
    @objc class func loadFromNib(withName name: String? = nil, owner: AnyObject? = nil, options: [AnyHashable: Any]? = nil) -> Self? {
        let nibName = name ?? self.shortClassName()
        
        return genericLoadFromNib(withName: nibName, owner: owner, options: options)
    }
    
    /**
     Helper function to allow `loadFromNib(withName:owner:options:)` to provide generic support of any UIView subclass type. This function
     gets object type cues as a result of being called from that function. This is a work around for Swift's current inability (as of v.2)
     to return an object cast to the type of Self.
     
     - parameter nibName: The name of the nib the view should be loaded from.
     - parameter owner: Optional. Used when loading the nib to specify the nib's owner, which allows for the setup of outlet properties.
     - parameter options: Optional. A dictionary containing the options to use when opening the nib file. For a list of available keys for this dictionary, see Nib File Loading Options.
     
     - returns: A view of the calling type or nil of the view could not be loaded.
     */
    fileprivate class func genericLoadFromNib<T: UIView>(withName nibName: String, owner: AnyObject?, options: [AnyHashable: Any]?) -> T? {
        guard let objects = Bundle.main.loadNibNamed(nibName, owner: owner, options: options as? [UINib.OptionsKey: Any]) else {
//            GDLog.error("FAILURE: The nib named '\(nibName)' could not be loaded.")
            return nil
        }
        
        for object in objects {
            if let view = object as? T {
                return view
            }
        }
        
        return nil
    }
}
