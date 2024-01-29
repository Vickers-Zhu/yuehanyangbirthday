//
//  ImExportZip.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/29.
//

import SwiftUI
import UniformTypeIdentifiers
import Zip // If using a third-party library for zipping



func exportMemes() {
    let fileManager = FileManager.default
    do {
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        let memesDirectory = documentsDirectory.appendingPathComponent("Yue_Memes")
        let zipFilePath = documentsDirectory.appendingPathComponent("Yue_Memes.zip")

        // Remove any existing zip file
        if fileManager.fileExists(atPath: zipFilePath.path) {
            try fileManager.removeItem(at: zipFilePath)
        }

        // Create a zip file
        try Zip.zipFiles(paths: [memesDirectory], zipFilePath: zipFilePath, password: nil, progress: nil)

        // Present a share sheet to save the zip file
        DispatchQueue.main.async {
            // Find the current UIWindowScene
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }

            let activityVC = UIActivityViewController(activityItems: [zipFilePath], applicationActivities: nil)
            rootViewController.present(activityVC, animated: true, completion: nil)
        }
    } catch {
        print("Export error: \(error)")
    }
}

//func importMemes() {
//    let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
//    documentPicker.delegate = documentPicker
//    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//    guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
//    rootViewController.present(documentPicker, animated: true, completion: nil)
//}
//
//func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
//    guard let selectedFileURL = urls.first else { return }
//
//    let fileManager = FileManager.default
//    do {
//        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//        let memesDirectory = documentsDirectory.appendingPathComponent("Yue_Memes")
//
//        // Remove any existing content in Yue_Memes directory
//        if fileManager.fileExists(atPath: memesDirectory.path) {
//            try fileManager.removeItem(at: memesDirectory)
//        }
//
//        // Unzip the file
//        try Zip.unzipFile(selectedFileURL, destination: documentsDirectory, overwrite: true, password: nil, progress: nil) { (success, error) in
//            if success {
//                print("Files successfully unzipped")
//            } else if let error = error {
//                print("Error unzipping file: \(error)")
//            }
//        }
//    } catch {
//        print("Import error: \(error)")
//    }
//}
