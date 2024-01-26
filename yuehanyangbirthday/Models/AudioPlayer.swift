//
//  AudioPlayer.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import Foundation
import AVFoundation
class AudioPlayer {
    static let shared = AudioPlayer()
    var audioPlayer: AVAudioPlayer?

    func playAudio(filepath: String?) {
        guard let filepath = filepath,
              let path = Bundle.main.path(forResource: filepath, ofType: nil) else{
                  print("Error: Audio file not found or filepath is nil")
                  return
                  
              }
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print("Error: Could not initialize the audio player.")
            }
        }
    func pause() {
        audioPlayer?.pause()
    }
}
