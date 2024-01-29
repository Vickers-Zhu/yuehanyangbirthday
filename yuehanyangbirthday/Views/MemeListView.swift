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
    @State private var isPresentingNewMemeSheet = false
    
    var body: some View {
        NavigationView {
            List{
                ForEach($memes, id: \.id) { $meme in
                      NavigationLink {
                          MemeDetail(meme: $meme)
                      } label: {
                          MemeRowView(meme: $meme)
                      }
                  }
                .onDelete(perform: deleteMeme)
                .navigationTitle("Memes")

            }
            .toolbar {
                Button(action: {
                    isPresentingNewMemeSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresentingNewMemeSheet){
            NewMemeSheet(memes: $memes, isPresentingNewMemeSheet: $isPresentingNewMemeSheet)
        }
    }
    private func deleteMeme(at offsets: IndexSet) {
        for index in offsets {
              let meme = memes[index]
              deleteImageFromDisk(named: meme.imageName)
          }
        memes.remove(atOffsets: offsets)
    }
}


#Preview {
    MemeListView(memes: .constant(Meme.sampleMemes))
}
