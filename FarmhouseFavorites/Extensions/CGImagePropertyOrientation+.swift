//
//  CGImagePropertyOrientation+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 1/28/22.
//

import Foundation
import UIKit

extension CGImagePropertyOrientation {
    init(uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
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
    
    func stringDescribing() -> String {
        switch self {
        case .up : return "up"
        case .down: return "down"
        case .upMirrored: return "upMirrored"
        case .downMirrored: return "downMirrored"
        case .left: return "left"
        case .leftMirrored: return "leftMirrored"
        case .right: return "right"
        case .rightMirrored: return "rightMirrored"
        default: return "Unknown"
        }
    }
}
