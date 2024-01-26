//
//  MemeStore.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/25.
//

import Foundation

class MemeStore: ObservableObject {
    @Published var memes: [Meme] = []

    private static func fileURL() throws -> URL {
        let fileManager = FileManager.default
        let documentsDirectory = try fileManager.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: false)
        
        let yueMemesDirectory = documentsDirectory.appendingPathComponent("Yue_Memes")
        
        // Check if the directory exists, if not, create it
        if !fileManager.fileExists(atPath: yueMemesDirectory.path) {
            try fileManager.createDirectory(at: yueMemesDirectory, withIntermediateDirectories: true)
        }

        return yueMemesDirectory.appendingPathComponent("Yue_memes.data")
    }

    func load() async throws {
        let task = Task<[Meme], Error> {
            let fileURL = try Self.fileURL()
            guard let data = try? Data(contentsOf: fileURL) else {
                return []
            }
            let memes = try JSONDecoder().decode([Meme].self, from: data)
            return memes
        }
        self.memes = try await task.value
    }

    func save(memes: [Meme]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(memes)
            let outfile = try Self.fileURL()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
