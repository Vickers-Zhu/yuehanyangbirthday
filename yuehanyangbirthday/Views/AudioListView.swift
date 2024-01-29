//
//  AudioListView.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/29.
//

import SwiftUI

struct AudioListView: View {
    @Binding var audioFilePath: String?

    var body: some View {
        Picker("选择一首歌曲", selection: $audioFilePath) {
            ForEach(AudioFile.audioFiles, id: \.self) { audioFile in
                Text(audioFile.name).tag(audioFile.filename)
            }
        }
    }
}



struct AudioListView_Previews: PreviewProvider {
    @State static var selectedAudioFilePath: String? = AudioFile.audioFiles[1].filename

    static var previews: some View {
        NavigationView {
            Form {
                AudioListView(audioFilePath: $selectedAudioFilePath)
            }
        }
    }
}
