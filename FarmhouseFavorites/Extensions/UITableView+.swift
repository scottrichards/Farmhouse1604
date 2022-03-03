//
//  UITableView+.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 3/3/22.
//

import Foundation
import UIKit

extension UITableView {
    /**
     Register a table view cell nib with the table view. Assumes that the nib name and intended reuse identifier match the class name of the cell.
     - parameter forType: The class of the table view cell for which a nib should be registered.
     */
    func registerNib<T: UITableViewCell>(forType: T.Type) {
        let identifier = String(describing: T.self)
        
        if let _ = Bundle.main.path(forResource: identifier, ofType: "nib") {
            let nib = UINib(nibName: identifier, bundle: Bundle.main)
            register(nib, forCellReuseIdentifier: identifier)
        } else {
            print("FAILURE: No nib found while attempting to register a UITableViewCell nib with a UITableView.")
        }
    }
    
    /**
     Dequeue a cell from the table view that was previously registered with the table. Assumes the cell's reuse identifier matches the name of the cell class.
     - parameter forType: The class of the table view cell that should be dequeued.
     */
    func dequeueCell<T: UITableViewCell>(forType: T.Type) -> T? {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: T.self)) as? T else {
            print("FAILURE: Failed to dequeue cell of type \(String(describing: T.self))")
            return nil
        }
        
        return cell
    }
}
