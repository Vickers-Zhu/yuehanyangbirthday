//
//  ImExportZip.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/29.
//

import SwiftUI
import UniformTypeIdentifiers
import Zip // If using a third-party library for zipping

func exportMemes(store: MemeStore, memes: [Meme]) async {
    let fileManager = FileManager.default
    do {
        try await store.save(memes: memes)
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

func deleteExportedZip() throws {
    let fileManager = FileManager.default
    let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let zipFilePath = documentsDirectory.appendingPathComponent("Yue_Memes.zip")

    // Remove any existing zip file
    if fileManager.fileExists(atPath: zipFilePath.path) {
        try fileManager.removeItem(at: zipFilePath)
    }
}



func processImportedFile(_ url: URL, store: MemeStore) async {
    do {
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        let destination = documentsDirectory.appendingPathComponent("Yue_Memes")
        
        // Check if the directory exists, if so, remove it
        if fileManager.fileExists(atPath: destination.path) {
            try fileManager.removeItem(at: destination)
        }
        // Unzip the file
        try Zip.unzipFile(url, destination: documentsDirectory, overwrite: true, password: nil, progress: nil)

        // After unzipping, load the data
        try await store.load()
    } catch {
        print("Error processing imported file: \(error)")
    }
}
