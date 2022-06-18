//
//  Logger.swift
//  TruColoriOS
//
//  Created by Scott Richards on 1/24/22.
//

import Foundation
import Logging
import FirebaseCrashlytics

class Log {
    static let logger : Logger = {
        var tempLog = Logger(label: "seboya.truhu.iosapp")
        tempLog.logLevel = .trace
        return tempLog
    }()
    
    static var logOutput: String = ""
    
    static func justFileName(path: String) -> String {
        if let fileName = path.substringAfter(character: "/") {
            return fileName
        } else {
            return ""
        }
    }
    
    static func log(level: Logger.Level, _ message: Logger.Message, file: String = #file, function: String = #function, line: Int = #line) {
        logger.log(level: level, message)
        logOutput = logOutput + "\n" + message.description
    }
    
    static func trace(_ message: Logger.Message, file: String = #file, function: String = #function, line: Int = #line) {
        logger.trace("file: \(justFileName(path: file)) func: \(function) #: \(line) \(message)")
        logOutput = logOutput + "\n" + "file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)"
    }
    
    static func debug(_ message: Logger.Message, quiet: Bool = false, file: String = #file, function: String = #function, line: Int = #line) {
        if quiet {
            logger.debug(message)
            logOutput = logOutput + "\n" + "\(message)"
        } else {
            logger.debug("file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)")
            logOutput = logOutput + "\n" + "file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)"
        }
    }
    
    static func warning(_ message: Logger.Message, file: String = #file, function: String = #function, line: Int = #line) {
        logger.warning("file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)")
        logOutput = logOutput + "\n" + "file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)"
    }
    
    /// An error occurred but not prevent an action from being completed
    static func error(_ message: Logger.Message, file: String = #file, function: String = #function, line: Int = #line) {
        logger.error("file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)")
        Crashlytics.crashlytics().log("file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)")
        logOutput = logOutput + "\n" + "file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)"
    }
    
    /// An error occurred but not prevent an action from being completed
    static func error(_ message: Logger.Message, error: Error?, file: String = #file, function: String = #function, line: Int = #line) {
        if let error = error {
            logger.error("file: \(justFileName(path: file))  func: \(function) #: \(line) \(message) Error: \(error.localizedDescription)")
            Crashlytics.crashlytics().log("file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)  Error: \(error.localizedDescription)")
            logOutput = logOutput + "\n" + "file: \(justFileName(path: file))  func: \(function) #: \(line) \(message) " + error.localizedDescription
        } else {
            Log.debug(message, quiet: false, file: file, function: function, line: line)
            logOutput = logOutput + "\n" + "file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)"
        }
        
    }
    
    /// An error occurred but not prevent an action from being completed
    static func error(error: Error?, file: String = #file, function: String = #function, line: Int = #line) {
        if let error = error {
            logger.error("file: \(justFileName(path: file))  func: \(function) #: \(line) Error: \(error.localizedDescription)")
            Crashlytics.crashlytics().log("file: \(justFileName(path: file))  func: \(function) #: \(line) Error: \(error.localizedDescription)")
            logOutput = logOutput + "\n" + "file: \(justFileName(path: file))  func: \(function) #: \(line) " + error.localizedDescription
        } else {
//            Log.debug(quiet: false, file: file, function: function, line: line)
            logOutput = logOutput + "\n" + "file: \(justFileName(path: file))  func: \(function) #: \(line)"
        }
        
    }
    
    /// Critical Highest priority means an action was unable to be completed
    static func critical(_ message: Logger.Message, file: String = #file, function: String = #function, line: Int = #line) {
        logger.critical("file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)")
        Crashlytics.crashlytics().log("file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)")
        logOutput = logOutput + "\n" + "file: \(justFileName(path: file))  func: \(function) #: \(line) \(message)"
    }

}


