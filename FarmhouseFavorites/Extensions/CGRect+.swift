//
//  CGRect+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 12/2/21.
//

import Foundation
import UIKit

extension CGRect {

    init(midOrigin: CGPoint, size: CGSize) {
        let topLeft = CGPoint(x: midOrigin.x - (size.width / 2), y: midOrigin.y - (size.height / 2))
        self.init(origin: topLeft, size: size)
    }
    
    func sizeToScale(scale: CGFloat) -> CGRect {
        let adjustRect = CGRect(x: self.origin.x * scale, y: self.origin.y * scale, width: self.size.width * scale, height: self.size.height * scale)
        return adjustRect
    }

    
}
