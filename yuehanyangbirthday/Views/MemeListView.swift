//
//  MemeListView.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import SwiftUI

struct MemeListView: View {
    // Sample memes data
    @Binding var memes: [Meme]
    
    var body: some View {
        List{
            ForEach($memes, id: \.id) { $meme in
                  NavigationLink {
                      MemeDetail(meme: $meme)
                  } label: {
                      MemeRowView(meme: $meme)
                  }
              }
            .onDelete(perform: deleteMeme)
            .onMove(perform: moveMeme)
        }
    }
    private func deleteMeme(at offsets: IndexSet) {
        for index in offsets {
              let meme = memes[index]
              deleteImageFromDisk(named: meme.imageName)
          }
        memes.remove(atOffsets: offsets)
    }
    private func moveMeme(from source: IndexSet, to destination: Int) {
        memes.move(fromOffsets: source, toOffset: destination)
    }
}


#Preview {
    MemeListView(memes: .constant(Meme.sampleMemes))
}
