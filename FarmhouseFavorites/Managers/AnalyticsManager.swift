//
//  AnalyticsManager.swift
//  FarmhouseFavorites
//
//  Created by Scott Richards on 6/18/22.
//

import Foundation
import UIKit

import FirebaseAnalytics

enum OperationSuccess: String {
    case success
    case failure
}

enum ScreenType: String {
    case SignIn
    case UnitDetails
    case Menu
    case Info
}


struct AnalyticsManagerOperationResult {
    let success: OperationSuccess
}

enum AnalyticsManagerEvent: String {
    case SignIn
    case SignUp
    case SignOut
    
    // Ably Mobile <-> Desktop
    case SendChangeScreen
    case CreateChannel
    case ReceivedSubscription   // When we are notified that someone has subscribed to a channel we are listening to
    
    case MeasurementComplete
    case ChangeBrightness
    case ChangeColorTemperature
    case LearnHowToSetDisplaysBrightness
    case RetakePhoto    // Parameter for which screen White, Gray, Color
    
    // Mac Specific
//        case CreatedProfile
//        case SavedProfile
//        case UseNewProfile
//        case UseOldProfile
//      case CalibrationReminder
}

class AnalyticsManager {
    
    static func log(event: AnalyticsManagerEvent, parameters: [String: String]?) {
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
    
    static func log(event: AnalyticsManagerEvent, success: Bool, error: Error?) {
        var parameters: [String:String] = ["result": success ? "success" : "failure"]
        if let error = error {
            parameters["error"] = error.localizedDescription
        }
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
    
    static func log(event: AnalyticsManagerEvent, error: Error?) {
        var parameters: [String:String] = ["result": error != nil ? "success" : "failure"]
        if let error = error {
            parameters["error"] = error.localizedDescription
        }
        Analytics.logEvent(event.rawValue, parameters: parameters)
    }
    
    static func logScreenChange(screen: ScreenType, error: Error?) {
        var parameters: [String:String] = ["screen": screen.rawValue]
        parameters["result"] = error != nil ? "success" : "failure"
        if let error = error {
            parameters["error"] = error.localizedDescription
        }
        Analytics.logEvent(AnalyticsManagerEvent.SendChangeScreen.rawValue, parameters: parameters)
    }
    
    static func createChannel(username: String) {
        Analytics.logEvent(AnalyticsManagerEvent.CreateChannel.rawValue, parameters: ["username": username])
    }
    
    /// Call when we are notified of a channel subscription
    static func receivedSubscription(data: String) {
        Analytics.logEvent(AnalyticsManagerEvent.ReceivedSubscription.rawValue, parameters: ["data": data])
    }
}
