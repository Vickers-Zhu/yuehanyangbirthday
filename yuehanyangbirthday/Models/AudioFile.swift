//
//  AudioFile.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/29.
//

import Foundation

struct AudioFile: Identifiable, Hashable, Equatable {
    let id = UUID()
    let name: String
    let filename: String?
}

extension AudioFile {
    static var audioFiles = [
        AudioFile(name: "无", filename: nil),
        AudioFile(name: "熄灭", filename: "熄灭.mp3"),
        AudioFile(name: "あの夏で待ってる", filename: "あの夏で待ってる.mp3")
    ]
}

extension AudioFile {
    static func findMatchingAudioFile(filename: String?) -> AudioFile {
        guard let filename = filename else {
            return AudioFile.audioFiles[0] // Assuming this is the 'none' case
        }
        return AudioFile.audioFiles.first { $0.filename == filename } ?? AudioFile.audioFiles[0]
    }
}
