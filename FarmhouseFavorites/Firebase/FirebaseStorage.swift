//
//  FirebaseStorage.swift
//  TruColoriO
//
//  Created by Scott Richards on 3/1/22.
//

import Foundation
import FirebaseStorage
import UIKit



protocol FirestoreUploaderDelegate: AnyObject {
    func updateProgress(percentComplete: Float)
//    func completionHandler(error: Error?, url: URL?, type: FileType?)
}

class FirestoreUploader {
    let fireBaseConsoleUrl = "https://console.firebase.google.com/u/0/project/truhu-pro/storage/truhu-pro.appspot.com/files"
    let dateTimeStamp: String
    let firestoreRoot: String
    weak var delegate: FirestoreUploaderDelegate?
    var storageReference: StorageReference?
    var fileStoreUrl: URL?
    var uploading: Bool = false
    
    init(dateTimeStamp: String) {
        self.dateTimeStamp = dateTimeStamp
        if let email = UserManager.singleton.user?.email {
            self.firestoreRoot = "/images/\(email)/\(dateTimeStamp)/"
        } else {
            self.firestoreRoot =  "/images/\(dateTimeStamp)/"
        }
    }
    
    var whiteFileName: String {
        return firestoreRoot + "White." + Configuration.singleton.capturePhotoType.fileTypeExtension
    }
    
    var grayFileName: String {
        return firestoreRoot + "Gray." + Configuration.singleton.capturePhotoType.fileTypeExtension
    }

    var colorFileName: String {
        return firestoreRoot + "Color." + Configuration.singleton.capturePhotoType.fileTypeExtension
    }

    var jsonFileName: String {
        return firestoreRoot + "Json.text"
    }

    func tempFileName(type: FileType, fileExtension: String) -> URL? {
//        let tempDir = FileManager.default.temporaryDirectory
        
        guard let tempDir = CalibrationStateManager.singleton.tempDirectory, let tempDir = URL(string: tempDir) else {
            return nil
        }
        switch type {
        case .White:
            let fileName = "\(dateTimeStamp)_White"
            return tempDir.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        case .Gray:
            let fileName = "\(dateTimeStamp)_Gray"
            return tempDir.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        case .Color:
            let fileName = "\(dateTimeStamp)_Color"
            return tempDir.appendingPathComponent(fileName).appendingPathExtension(fileExtension)
        case .JSON:
            let fileName = "\(dateTimeStamp)_Json"
            return tempDir.appendingPathComponent(fileName).appendingPathExtension("text")
        }
    }
    
    func saveJson(jsonString: String) {
        uploading = true
        let metaData = StorageMetadata.init()
        metaData.contentType = "application/json"
        let fireStorePath = jsonFileName
        self.storageReference = Storage.storage().reference().child(fireStorePath)
        guard let storageReference = storageReference else {
            return
        }
        let data = Data(jsonString.utf8)
        let uploadTask = storageReference.putData(data, metadata: metaData, completion: {
            [weak self] (metaData, error) in
            if let error = error {
                Log.error("Upload error: \(error.localizedDescription)")
                return
            }
            
            // Show UIAlertController here
            Log.debug("Json file: \(fireStorePath) is uploaded! View it at Firebase console!")
            
            storageReference.downloadURL {
                [weak self] (url, error) in
                guard let self = self else {
                    return
                }
                if let error = error  {
                    Log.error("Error on getting download url: \(error.localizedDescription)")
                    self.delegate?.completionHandler(error: error, url: nil, type: .JSON)
                    return
                }
                self.fileStoreUrl = url
                Log.debug("Download url of \(fireStorePath) is \(url!.absoluteString)")
                self.uploading = false
                self.delegate?.completionHandler(error: error, url: url, type: .JSON)
            }
        })
        uploadTask.observe(.progress) { [weak self] (taskSnapshot) in
            guard let self = self else {
                return
            }
            guard let fractionCompleted = taskSnapshot.progress?.fractionCompleted else {
                return
            }
            let percentCompleted = Float(fractionCompleted)
            Log.debug("percent complete: \(percentCompleted)")
            if percentCompleted < 1 {
                self.delegate?.updateProgress(percentComplete: percentCompleted)
            }
        }
    }
        
    func saveToTempFile(data: Data, type: FileType) -> URL? {
        uploading = true
        let fileExtension = Configuration.singleton.capturePhotoType.fileTypeExtension
        let rawTempFileUrl = tempFileName(type: type, fileExtension: fileExtension)
        guard let rawTempFileUrl = rawTempFileUrl else {
            return nil
        }
        Log.debug("Saving to Temp File: \(rawTempFileUrl)")
        do {
            // Write the RAW (DNG) file data to a local temp file
            try data.write(to: rawTempFileUrl)
        } catch {
            Log.critical("Couldn't save DNG file to the temp URL. error: \(error)")
            return nil
        }
        return rawTempFileUrl
    }
  
    func uploadFileTemp(data: Data, type: FileType) {
        uploading = true
        guard let tempFileUrl = saveToTempFile(data: data, type: type) else {
            return
        }
        var firestorePath = ""
        switch type {
        case .White:
            firestorePath = whiteFileName
        case .Gray:
            firestorePath = grayFileName
        case .Color:
            firestorePath = colorFileName
        case .JSON:
            firestorePath = jsonFileName
        }

        self.storageReference = Storage.storage().reference().child(firestorePath)
        guard let storageReference = storageReference else {
            return
        }

        // Create a reference to the file you want to upload
//        let fireStoreRef = storageReference.child(firestorePath)

        // Upload the file to the path "images/rivers.jpg"
        let uploadTask = storageReference.putFile(from: tempFileUrl, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                Log.critical("Error saving file \(tempFileUrl) to firestore path: \(firestorePath)")
                return
            }
            // Metadata contains file metadata such as size, content-type.
            let size = metadata.size
            Log.debug("Firestorage upload file Size: \(size)")
            // You can also access to download URL after upload.
            storageReference.downloadURL { (url, error) in
                self.uploading = false
                guard let downloadURL = url else {
                    Log.critical("Could not get firebase storage path: \(firestorePath)")
                    return
                }
                Log.debug("Save to firebase storage url: \(downloadURL.absoluteString)")
                self.fileStoreUrl = url
                Log.debug("Download url of \(firestorePath) is \(url!.absoluteString)")
                self.delegate?.completionHandler(error: error, url: url, type: type)
            }
        }
        uploadTask.observe(.progress) { [weak self] (taskSnapshot) in
            guard let self = self else {
                return
            }
            guard let fractionCompleted = taskSnapshot.progress?.fractionCompleted else {
                return
            }
            let percentCompleted = Float(fractionCompleted)
            Log.debug("percent complete: \(percentCompleted)")
            if percentCompleted < 1 {
                self.delegate?.updateProgress(percentComplete: percentCompleted)
            }
        }
    }
    
    func uploadFile(data: Data, type: FileType) {
        uploading = true
        let metaData = StorageMetadata.init()
        metaData.contentType = Configuration.singleton.capturePhotoType.contentType
        var firestorePath = ""
        switch type {
        case .White:
            firestorePath = whiteFileName
        case .Gray:
            firestorePath = grayFileName
        case .Color:
            firestorePath = colorFileName
        case .JSON:
            firestorePath = jsonFileName
        }
        self.storageReference = Storage.storage().reference().child(firestorePath)
        guard let storageReference = storageReference else {
            return
        }
        let currentUploadTask = storageReference.putData(data, metadata: metaData, completion: {
            [weak self] (metaData, error) in
            if let error = error {
                Log.error("Upload error: \(error.localizedDescription)")
                return
            }

            // Show UIAlertController here
            Log.debug("Image file: \(firestorePath) is uploaded! View it at Firebase console!")

            storageReference.downloadURL {
                [weak self] (url, error) in
                guard let self = self else {
                    return
                }
                if let error = error  {
                    Log.error("Error on getting download url: \(error.localizedDescription)")
                    self.delegate?.completionHandler(error: error, url: nil, type: type)
                    return
                }
                self.fileStoreUrl = url
                Log.debug("Download url of \(firestorePath) is \(url!.absoluteString)")
                self.uploading = false
                self.delegate?.completionHandler(error: error, url: url, type: type)
            }
        })
        
        currentUploadTask.observe(.progress) { [weak self] (taskSnapshot) in
            guard let self = self else {
                return
            }
            guard let fractionCompleted = taskSnapshot.progress?.fractionCompleted else {
                return
            }
            let percentCompleted = Float(fractionCompleted)
            Log.debug("percent complete: \(percentCompleted)")
            if percentCompleted < 1 {
                self.delegate?.updateProgress(percentComplete: percentCompleted)
            }
        }
    }
    
    func uploadFile(from: URL, to: String, type: FileType) {
        uploading = true
        let metaData = StorageMetadata.init()
        metaData.contentType = Configuration.singleton.capturePhotoType.contentType
        self.storageReference = Storage.storage().reference().child(to)
        guard let storageReference = storageReference else {
            return
        }
//        let currentUploadTask = storageReference.putData(data, metadata: metaData, completion: {
        let uploadTask = storageReference.putFile(from: from, metadata: metaData, completion: { [weak self] metaData, error in
            if let error = error {
                Log.error("Upload error: \(error.localizedDescription)")
                return
            }

            // Show UIAlertController here
            Log.debug("Image file: \(to) is uploaded! View it at Firebase console!")

            storageReference.downloadURL {
                [weak self] (url, error) in
                guard let self = self else {
                    return
                }
                if let error = error  {
                    Log.error("Error on getting download url: \(error.localizedDescription)")
                    self.delegate?.completionHandler(error: error, url: nil, type: type)
                    return
                }
                self.fileStoreUrl = url
                Log.debug("Download url of \(to) is \(url!.absoluteString)")
                self.uploading = false
                self.delegate?.completionHandler(error: error, url: url, type: type)
            }
        })
        
        uploadTask.observe(.progress) { [weak self] (taskSnapshot) in
            guard let self = self else {
                return
            }
            guard let fractionCompleted = taskSnapshot.progress?.fractionCompleted else {
                return
            }
            let percentCompleted = Float(fractionCompleted)
            Log.debug("percent complete: \(percentCompleted)")
            if percentCompleted < 1 {
                self.delegate?.updateProgress(percentComplete: percentCompleted)
            }
        }
    }
}

