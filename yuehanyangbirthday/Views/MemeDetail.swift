//
//  MemeDetail.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import SwiftUI

struct MemeDetail: View {
    var meme: Meme
    @State private var isPlaying = false
    var body: some View {
        VStack{
            CircleImage(image: meme.image)
                       .offset(y: -130)
                       .padding(.top, -40)
            VStack(alignment: .center) {
                Text(meme.title)
                    .font(.title)
                
                
                HStack {
                    Text(meme.content)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
            .padding(.top, -250)
            PlayView(filepath: meme.audioFilePath)
        }
        .navigationTitle(meme.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    MemeDetail(meme: Meme.memes[0])
}
