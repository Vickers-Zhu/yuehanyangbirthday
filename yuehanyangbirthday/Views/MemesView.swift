//
//  ContentView.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import SwiftUI

struct MemesView: View {
    @Binding var memes: [Meme]
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        MemeListView(memes: $memes)
            .onChange(of: scenePhase) { oldScenePhase, newScenePhase in
                if newScenePhase == .inactive {saveAction()}
            }
    }
}

#Preview {
    MemesView(memes: .constant(Meme.sampleMemes), saveAction: {})
}
