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
    @EnvironmentObject var store: MemeStore
    @State private var isPresentingNewMemeSheet = false
    @State private var isPresentingZipPicker = false
    let saveAction: () -> Void
    
    var body: some View {
        NavigationView {
            MemeListView(memes: $memes)
                .onAppear {
                    Task {
                        try deleteExportedZip()
                    }
                }
                .navigationTitle("Memes")
                .onChange(of: scenePhase) { oldScenePhase, newScenePhase in
                    if newScenePhase == .inactive {saveAction()}
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isPresentingZipPicker = true
                        }) {
                            Text("Import")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isPresentingNewMemeSheet = true
                        }) {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {
                            Task {
                                await exportMemes(store: store, memes: memes)
                            }
                        }) {
                           Text("Export")
                       }
                    }
          
                }
        }
        .sheet(isPresented: $isPresentingNewMemeSheet){
            NewMemeSheet(memes: $memes, isPresentingNewMemeSheet: $isPresentingNewMemeSheet)
        }
        .sheet(isPresented: $isPresentingZipPicker){
            ZipFilePicker { url in
                Task {
                    await processImportedFile(url, store: store)
                }
            }
            
        }
    }
}


#Preview {
    MemesView(memes: .constant(Meme.sampleMemes), saveAction: {})
}
