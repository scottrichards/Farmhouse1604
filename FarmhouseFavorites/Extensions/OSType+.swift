//
//  OSType+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 1/29/22.
//

import Foundation


extension OSType {
    ///  Convert Four Character OSType to Human Readable String
    func stringDescribing() -> String {
        let utf16 = [
            UInt16((self >> 24) & 0xFF),
            UInt16((self >> 16) & 0xFF),
            UInt16((self >> 8) & 0xFF),
            UInt16((self & 0xFF)) ]
        return String(utf16CodeUnits: utf16, count: 4)
    }
}
