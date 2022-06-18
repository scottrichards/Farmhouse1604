//
//  DateUtilities.swift
//  TruColoriOS
//
//  Created by Scott Richards on 10/21/21.
//

import Foundation


class DateUtilities {
    static let singleton = DateUtilities()
    
    func dateTimeStamp() -> String {
        let now = Date()

        let formatter = DateFormatter()

        formatter.timeZone = TimeZone.current

        formatter.dateFormat = "yyyy-MM-dd-HH-mm-ss"

        let dateString = formatter.string(from: now)
        print("Datestring: \(dateString)")
        return dateString
    }
}
