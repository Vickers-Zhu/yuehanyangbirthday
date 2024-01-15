//
//  MemeListView.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import SwiftUI

struct MemeListView: View {
    // Sample memes data
    
    var body: some View {
        NavigationView {
            List(Meme.memes) { meme in
                NavigationLink {
                    MemeDetail(meme: meme)
                } label: {
                    MemeRowView(meme: meme)
                }
                .navigationTitle("Memes")
                
            }
        }
    }
}


#Preview {
    MemeListView()
}
