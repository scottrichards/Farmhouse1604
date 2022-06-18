//
//  Constants.swift
//  TruColoriOS
//
//  Created by Scott Richards on 12/11/21.
//

import Foundation
import UIKit

struct Constants {
    struct Urls {
        static let Booking = "https://farmhouse1604.com/anfrage-buchung-farmhouse.html"
        static let Privacy = "https://farmhouse1604.com/datenschutz.html"
        static let contact = "https://farmhouse1604.com/impressum.html"
        static let map = "https://www.google.com/maps/place/Farmhouse+1604/@47.841306,12.488194,16z/data=!4m5!3m4!1s0x47766f334ac4d143:0xb9e9633defac98eb!8m2!3d47.841149!4d12.4880192?hl=en"
    }
    
    struct email {
        static let info = "info@farmhouse1604.de"
    }
    
    struct phoneNumber {
        static let whatsAppService = "01752674438"
    }
    
    struct Notifications {
        static let AppConfigurationLoaded = Notification.Name(rawValue: "AppConfigurationLoaded")
        static let UserStatusChange = Notification.Name(rawValue: "UserStatusChange")
        static let ChannelSubscriptionChange = Notification.Name(rawValue: "ChannelSubscriptionChange")
    }
    
    struct Storyboard {
        static let WelcomeVC = "WelcomeVC"
        static let SignInOrSignUpVC = "SignInOrSignUpVC"
    }
    
    struct UserDefaults {
        static let acceptedTermsofUse = "acceptedTermsofUse"
    }
}


