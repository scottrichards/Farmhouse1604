//
//  UIImageOrientation+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 1/28/22.
//

import Foundation
import UIKit

extension UIImage.Orientation {
    init(cgOrientation: CGImagePropertyOrientation) {
        switch cgOrientation {
            case .up: self = .up
            case .upMirrored: self = .upMirrored
            case .down: self = .down
            case .downMirrored: self = .downMirrored
            case .left: self = .left
            case .leftMirrored: self = .leftMirrored
            case .right: self = .right
            case .rightMirrored: self = .rightMirrored
        }
    }
}
