//
//  CGPoint+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 1/15/22.
//

import Foundation
import UIKit

extension CGPoint {
    static func *(lhs: inout CGPoint, rhs: CGFloat) {
        lhs.x = lhs.x * rhs
        lhs.y = lhs.y * rhs
    }
}
