//
//  VNRectangleObservation+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 1/28/22.
//

import Foundation
import UIKit
import Vision

extension VNRectangleObservation {
    
//    /// Returns a bounding rectangle by converting from normalized coordinates of a VNRectangleObservation into the coordinates of a frame or an image of given size
//    func imageRectFor(size: CGSize) -> CGRect {
//        return VNImageRectForNormalizedRect(self.boundingBox, Int(size.width), Int(size.height))
//    }
    
    /// Returns the bounding rectangle by converting from normalized coordinates of a VNRectangleObservation into the coordinates of a frame or an image of given size in the coordinate space of iOS where top is 0,0 from Visions Mac OS Based coordinate system Where the origin 0,0 is in the bottom left
    func normalizedRectForIOS(size: CGSize) -> CGRect {
        var normalizedRect = VNImageRectForNormalizedRect(self.boundingBox, Int(size.width), Int(size.height))
        // Flip the Y Coordinates to be based on top left instead of starting from bottom left
        normalizedRect.origin.y = size.height - (normalizedRect.origin.y + normalizedRect.height)
        return normalizedRect
    }
}
