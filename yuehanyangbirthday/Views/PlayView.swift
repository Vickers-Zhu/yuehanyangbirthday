//
//  PlayView.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import SwiftUI

struct PlayView: View {
    var filepath: String
    @State private var isPlaying = false
    private let audioPlayer = AudioPlayer.shared

    var body: some View {
        Button(action: togglePlayPause) {
            Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .foregroundColor(.blue)
        }
    }

    private func togglePlayPause() {
        isPlaying.toggle()
        if isPlaying {
            audioPlayer.playAudio(filepath: filepath)
        } else {
            audioPlayer.pause()
        }
    }
}

#Preview {
    PlayView(filepath: "熄灭.mp3")
}
