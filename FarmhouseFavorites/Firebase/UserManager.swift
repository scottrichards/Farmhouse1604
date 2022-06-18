//
//  UserManager.swift
//  TruColoriOS
//
//  Created by Scott Richards on 9/21/21.
//

import Foundation
import Firebase
import FirebaseAuth
import Combine


typealias AuthDataResultCallback = (AuthDataResult?,Error?)->()

class UserManager : ObservableObject {
    static var singleton = UserManager()
    var didChange = PassthroughSubject<UserManager, Never>()
    @Published var user: User? { didSet { self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    var signedIn: Bool {
        return user != nil
    }
    
    init() {
        self.listen()
    }
    
    deinit {
        unbind()
    }
    
    /// Set up authentication state change listener
    func listen () {
        // monitor authentication changes using firebase
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if let user = user {
                // if we have a user, create a new user model
                Log.debug("--  Authentication State Change User Authented: \(dump(user))")
                self.user = user
                // Establish Websocket connection based on the user's email address to connect to Mac app
// I was experimenting with using Firebase Messaging to solve the iOS Client to Desktop problem
//                let pushManager = PushNotificationManager(userID: user.uid)
//                pushManager.registerForPushNotifications()
            } else {
                // if we don't have a user, set our session to nil
                self.user = nil
                Log.debug("-- Authentication Stage Change NO User is Signed In")
            }
            // TODO: Do we want to post notifications?
            NotificationCenter.default.post(name: Constants.Notifications.UserStatusChange, object: nil)
        }
    }
    
    /// Create a new Firebase user
    func signUp(
        email: String,
        password: String,
        displayName: String? = nil,
        completion: @escaping AuthDataResultCallback)
    {
        Auth.auth().createUser(withEmail: email, password: password, completion:
        { result, error in
            if let displayName = displayName {
                self.updateUser(name: displayName) { error in
                    if let error = error {
                        Log.error("Error Adding Display Name at Account Creation error: \(error.localizedDescription)")
                    } else {
                        Log.debug("SUCCESS: Added display name \(displayName) to new user.")
                    }
                }
            }
            completion(result, error)
            
        })
//        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    /// Sign in a user to Firebase
    func signIn(
        email: String,
        password: String,
        completion: @escaping AuthDataResultCallback)
    {

        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
//            TruHuAnalytics.log(event: TruHuAnalyticsEvent.SignIn, error: error)
            if let error = error {
                Log.error("ERROR: Failed to Sign In: \(error.localizedDescription)")
            } else {
                Log.debug("SUCCESS: Signed In")
            }
            completion(result, error)
        }
    }
    
    /// Update the users Displayed Name
    func updateUser(name: String, completion: ((Error?) -> Void)?) {
        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
            changeRequest.displayName = name
            changeRequest.commitChanges { (error) in
                completion?(error)
            }
        }
    }
    
    /// Update the Users email Not using this yet
    func updateEmail(email: String, completion: (Error) -> Void ) {
        if let currentUser = Auth.auth().currentUser {
            currentUser.updateEmail(to: email, completion: { error in
                // error
                if let error = error {
                    Log.debug("-- updateEmail ERROR updating email \(error.localizedDescription)")
                } else {
                    Log.debug("SUCCESS: updated email to: \(email)")
                }
            })
        }
    }
    
//    func updateUserName(first: String, last: String) {
//        if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
//            changeRequest.displayName = first + " " + last
//            changeRequest.commitChanges { error in
//                Log.error("Updated user", error: error)
//            }
//        }
//    }
    
    func signOut(completion: ((Bool) -> Void)?) {
        do {
            try Auth.auth().signOut()
            self.user = nil
            Log.debug("SUCCESS: User Signed Out")
            completion?(true)
        } catch {
            completion?(false)
            Log.debug("ERROR: Signing Out")
        }
    }
    
    func sendPasswordReset(email: String, completion: ((Error?) -> Void)?) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                Log.error("ERROR: Failed to send Password Reset: \(error.localizedDescription)")
            } else {
                Log.debug("SUCCESS: Sent Password Reset")
            }
            completion?(error)
        }
    }
    
    ///
    func unbind () {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
