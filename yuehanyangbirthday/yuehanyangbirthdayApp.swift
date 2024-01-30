//
//  yuehanyangbirthdayApp.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import SwiftUI

@main
struct yuehanyangbirthdayApp: App {
//    @State private var memes = Meme.sampleMemes
    @State private var memes: [Meme] = []
    @StateObject private var store = MemeStore()
    var body: some Scene {
        WindowGroup {
            MemesView(memes: $store.memes) {
                Task{
                    do {
                        try await store.save(memes: store.memes)
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
            }
            .environmentObject(store)
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
}
