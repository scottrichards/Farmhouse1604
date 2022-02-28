//
//  NSObject+.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 2/28/22.
//

import Foundation


extension NSObject {
    /**
     In Swift, a class name includes the fully qualified package name, like "Framework.ClassName". We define the
     'full' class name to be "Framework.ClassName" and the 'short' class name to be the last component in this
     dot-separated name. In this example, the 'short' name is "ClassName".
     
     - returns: The 'short' class name.
     */
    @objc public class func shortClassName() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    
    /**
     In Swift, a class name includes the fully qualified package name, like "Framework.ClassName". We define the
     'full' class name to be "Framework.ClassName" and the 'short' class name to be the last component in this
     dot-separated name. In this example, the 'short' name is "ClassName".
     
     - returns: The 'short' class name.
     */
    @objc public func shortClassName() -> String {
        return String(describing: type(of: self))
    }
    
    /**
     In Swift, a class name includes the fully qualified package name, like "Framework.ClassName". We define the
     'full' class name to be "Framework.ClassName" and the 'short' class name to be the last component in this
     dot-separated name. In this example, the 'short' name is "ClassName".
     
     - returns: The 'full' class name.
     */
    public class func fullClassName() -> String {
        return NSStringFromClass(self)
    }
    
    /**
     In Swift, a class name includes the fully qualified package name, like "Framework.ClassName". We define the
     'full' class name to be "Framework.ClassName" and the 'short' class name to be the last component in this
     dot-separated name. In this example, the 'short' name is "ClassName".
     
     - returns: The 'full' class name.
     */
    public func fullClassName() -> String {
        return NSStringFromClass(type(of: self))
    }
}
