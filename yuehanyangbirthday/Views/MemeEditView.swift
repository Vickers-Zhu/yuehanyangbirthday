//
//  MemeEditView.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/22.
//

import SwiftUI

struct MemeEditView: View {
    @Binding var meme: Meme
    @State private var isImagePickerPresented = false
    
    var body: some View {
        Form{
            Section(header: Text("阳阳🌻和小🐷的梗编辑")){
                TextField("主题", text: $meme.title)
            }
            Section(header: Text("阳阳🌻和小🐷的故事写在这里")){
                VStack(alignment: .leading){
                    if meme.content.isEmpty{
                        Text("👻")
                            .foregroundColor(.gray)
                            .opacity(0.5)
                    }
         
                    TextEditor(text: $meme.content)
                        .frame(minHeight: meme.content.isEmpty ? 70: 100) // Adjust the height as needed
                        .onTapGesture {
                            if meme.content.isEmpty{
                                meme.content = " "
                            }
                        }
                }
//                TextField("👻", text: $meme.content)
            }
            Section(header: Text("选择图片")) {
               VStack {
                   if let image = meme.image {
                       image
                          .resizable()
                          .scaledToFit()
                   } else {
                      Text("点击选择图片")
                          .foregroundColor(.gray)
                  }
               }
               .onTapGesture {
                       isImagePickerPresented = true
               }
            }
            Section(header: Text("选择BGM")) {
                AudioListView(audioFilePath: $meme.audioFilePath)
            }
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(imageName: $meme.imageName)
        }
    }
}

#Preview {
    MemeEditView(meme: .constant(Meme.sampleMemes[0]))
}
