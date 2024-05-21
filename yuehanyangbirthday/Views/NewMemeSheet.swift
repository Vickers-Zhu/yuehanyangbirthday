//
//  NewMemeSheet.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/26.
//

import SwiftUI

struct NewMemeSheet: View {
    @State private var newMeme = Meme.emptyMeme
    @Binding var memes: [Meme]
    @Binding var isPresentingNewMemeSheet: Bool
    var body: some View {
        NavigationView {
            MemeEditView(meme: $newMeme)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("取消") {
                            isPresentingNewMemeSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction) {
                        Button("保存") {
                            memes.insert(newMeme, at: 0)
                            isPresentingNewMemeSheet = false
                        }
                    }
                }
        }
    }
}

#Preview {
    NewMemeSheet(memes: .constant(Meme.sampleMemes),  isPresentingNewMemeSheet: .constant(true))
}
