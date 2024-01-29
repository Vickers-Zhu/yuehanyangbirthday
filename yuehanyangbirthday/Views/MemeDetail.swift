//
//  MemeDetail.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import SwiftUI

struct MemeDetail: View {
    @Binding var meme: Meme
    
    @State private var editingMeme = Meme.emptyMeme
    @State private var isPresentingEditView = false
    @State private var isPlaying = false

    var body: some View {
        VStack{
            CircleImage(image: meme.image ?? Image(systemName: "exclamationmark.triangle"))
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
            .padding(.top, -100)
            if let audioFilePath = meme.audioFilePath {
                PlayView(filepath: audioFilePath)
            }
        }
        .navigationTitle(meme.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("编辑") {
                editingMeme = meme
                isPresentingEditView = true
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                MemeEditView(meme: $editingMeme)
                  .navigationTitle(meme.title)
                  .toolbar{
                      ToolbarItem(placement: .cancellationAction){
                          Button("取消") {
                              isPresentingEditView = false
                          }
                      }
                      ToolbarItem(placement: .confirmationAction) {
                          Button("完成") {
                              isPresentingEditView = false
                              meme = editingMeme
                          }
                      }
                  }
            }
        }
        .onDisappear {
            AudioPlayer.shared.pause()
        }
    }
}

#Preview {
    MemeDetail(meme: .constant(Meme.sampleMemes[1]))
}
