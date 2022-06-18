//
//  CGColor+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 2/12/22.
//

import Foundation
import UIKit

extension CGColor {

    /// Return corresponding Color for the RGB values represented from 0 - 255 with specified Alpha (defaults to 1)
    static func initialize(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1.0) -> CGColor {
        return CGColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
    }
    
    /// Return corresponding Gray for the value represented from 0 - 255
    static func initGray(_ value: CGFloat) -> CGColor {
        return CGColor(red: value / 255.0, green: value / 255.0, blue: value / 255.0, alpha: 1.0)
    }
    
    /// Return corresponding Gray for the value represented from 0 - 255
    static func initGray(hex: String) -> CGColor {
        let intValue = UInt8(strtoul(hex, nil, 16))
        return CGColor.initGray(CGFloat(intValue))
    }
    
    /**
     Create a UIColor from a 6 character hex string with an optional '#' prefix. Optional alpha component is defaulted to 1.0.
     - parameters:
     - hexString: A six character hex representation of a color with or without a leading '#' character.
     - alpha: Optional alpha value for the color. Defaults to 1.0.
     */
    static func initialize(hexString: String, alpha: CGFloat = 1.0) -> CGColor? {
        guard hexString.count == 6 || (hexString.count == 7 && hexString.hasPrefix("#")) else {
            return nil
        }
        
        var hexInt: UInt32 = 0
        
        let scanner: Scanner = Scanner(string: hexString)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        
        if !scanner.scanHexInt32(&hexInt) {
            return nil
        }
        
        let red = CGFloat((hexInt & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexInt & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexInt & 0xff) >> 0) / 255.0
        let alpha = alpha
        
        return CGColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /// Return a Hex String representing the color e.g #ff0000
    var hexString: String {
        guard let components = self.components, components.count > 2 else {
            return "#unknown"
        }
        
        let r: CGFloat = components[0]
        let g: CGFloat = components[1]
        let b: CGFloat = components[2]

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
     }
}
