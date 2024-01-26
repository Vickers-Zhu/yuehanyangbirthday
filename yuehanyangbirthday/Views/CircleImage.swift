//
//  ProfileImage.swift
//  yuehanyangbirthday
//
//  Created by Vickers Zhu on 2024/1/16.
//

import SwiftUI


struct CircleImage: View {
    var image: Image
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: 300, height: 300)
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}


#Preview {
    CircleImage(image: Image("Profile_Yue_Torigoe"))
}
