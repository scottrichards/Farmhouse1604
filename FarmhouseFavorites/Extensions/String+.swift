//
//  UIString+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 1/25/22.
//

import Foundation

extension String {
    
    /// Returns the string after the last instance of the specified character in the original string
    func substringAfter(character: Character) -> String? {
        if let index = self.lastIndex(of: character) {
            let afterEqualsTo = String(self.suffix(from: index).dropFirst())
            return afterEqualsTo
        } else {
            return nil
        }
    }
}
