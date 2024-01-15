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
    var image: Image {
         Image(imageName)
     }
    var audioFilePath: String
}

extension Meme {
    static var memes: [Meme] {
        [
            Meme(title: "Meme 1", content: "asdasd", imageName: "Profile_Yue_1", audioFilePath: "熄灭.mp3")

        ]
    }
}

