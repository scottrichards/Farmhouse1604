//
//  UIApplication+.swift
//  TruColoriOS
//
//  Created by Scott Richards on 1/29/22.
//

import Foundation
import UIKit


extension UIApplication {
    struct Constants {
        static let CFBundleShortVersionString = "CFBundleShortVersionString"
    }
    class func appVersion() -> String {
        return Bundle.main.object(forInfoDictionaryKey: Constants.CFBundleShortVersionString) as! String
    }
  
    class func appBuild() -> String {
        return Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as! String
    }
  
    class func versionBuild() -> String {
        let version = appVersion(), build = appBuild()
      
        return version == build ? "v\(version)" : "v\(version) (\(build))"
    }
}
