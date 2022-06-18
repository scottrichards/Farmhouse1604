//
//  UIDeviceOrientation+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 1/27/22.
//

import Foundation
import UIKit

extension UIDeviceOrientation {
    func getUIImageOrientationFromDevice() -> UIImage.Orientation {
        // return CGImagePropertyOrientation based on Device Orientation
        // This extented function has been determined based on experimentation with how an UIImage gets displayed.
        switch self {
        case UIDeviceOrientation.portrait, .faceUp: return UIImage.Orientation.right
        case UIDeviceOrientation.portraitUpsideDown, .faceDown: return UIImage.Orientation.left
        case UIDeviceOrientation.landscapeLeft: return UIImage.Orientation.up // this is the base orientation
        case UIDeviceOrientation.landscapeRight: return UIImage.Orientation.down
        case UIDeviceOrientation.unknown: return UIImage.Orientation.up
        default: return UIImage.Orientation.up
        }
    }
    
    var stringForOrientation: String {
        switch self {
        case .faceUp: return "faceUp"
        case .portrait: return "portrait"
        case .faceDown: return "faceDown"
        case .landscapeLeft: return "landscapeLeft"
        case .landscapeRight: return "landscapeRight"
        case .portraitUpsideDown: return "portraitUpsideDown"
        default: return "Unknown"
        }
    }
}
