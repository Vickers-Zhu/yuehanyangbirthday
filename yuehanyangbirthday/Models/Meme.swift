//
//  Memes.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import Foundation
import SwiftUI

struct Meme: Hashable, Codable, Identifiable {
    var id = UUID()
    var title: String
    var content: String
    var imageName: String
    var image: Image? {
        loadImage(named: imageName)
     }
    var audioFilePath: String?
    
    init(id: UUID = UUID(), title: String, content: String, imageName: String, audioFilePath: String? = nil) {
        self.id = id
        self.title = title
        self.content = content
        self.imageName = imageName
        self.audioFilePath = audioFilePath
    }
    
    private func loadImage(named imageName: String) -> Image? {
        let folderPath = getDocumentsDirectory().appendingPathComponent("Yue_Memes")
        let imagePath = folderPath.appendingPathComponent(imageName)
        guard let uiImage = UIImage(contentsOfFile: imagePath.path) else {
            return nil
        }
        return Image(uiImage: uiImage)
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

extension Meme {
    static var emptyMeme: Meme{
        Meme(id: UUID(), title: "", content: "", imageName: "")
    }
}

extension Meme {
    static var sampleMemes: [Meme] {
        [
            Meme(title: "Meme 1", content: "asdasd", imageName: "Profile_Yue_1", audioFilePath: nil),
            Meme(title: "上野公园", content: "岳含阳看到两层楼高的楼梯就不爬了", imageName: "Profile_Yue_Torigoe", audioFilePath: "熄灭.mp3")

        ]
    }
}

