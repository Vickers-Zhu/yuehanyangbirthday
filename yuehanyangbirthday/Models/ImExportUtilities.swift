//
//  ImExportUtilities.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/29.
//

//import UniformTypeIdentifiers
//import Zip  If using a third-party library for zipping

//func exportMemes() {
//        let fileManager = FileManager.default
//        do {
//            let documentsDirectory = try fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            let yueMemesDirectory = documentsDirectory.appendingPathComponent("Yue_Memes")
//            let zipFilePath = documentsDirectory.appendingPathComponent("Yue_Memes.zip")
//
//            if fileManager.fileExists(atPath: zipFilePath.path) {
//                try fileManager.removeItem(at: zipFilePath)
//            }
//            
//            try fileManager.zipItem(at: yueMemesDirectory, to: zipFilePath)
//
//            let activityVC = UIActivityViewController(activityItems: [zipFilePath], applicationActivities: nil)
//            UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
//        } catch {
//            print("Export failed: \(error)")
//        }
//    }
