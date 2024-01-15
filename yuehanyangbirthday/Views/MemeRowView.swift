//
//  MemeRowView.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import SwiftUI

struct MemeRowView: View {
    var meme: Meme


    var body: some View {
        HStack {
            meme.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(meme.title)


            Spacer()
        }
    }
}


#Preview {
    MemeRowView(meme: Meme.memes[0])
}
