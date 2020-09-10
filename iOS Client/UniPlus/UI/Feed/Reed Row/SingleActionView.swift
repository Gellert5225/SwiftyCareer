//
//  SingleActionView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/10/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct SingleActionView: View {
    let size: CGFloat = 18
    let imageName: String
    let selectedImageName: String?
    let selectedColor: Color?
    @State var shouldChangeImage: Bool
    @State var number: Int
    
    var body: some View {
        HStack {
            Image(shouldChangeImage ? selectedImageName! : imageName).resizable()
                .frame(width: size, height: size)
            Text("\(number)")
                .foregroundColor(shouldChangeImage ? selectedColor! : .light_gray)
                .font(.custom("SF UI Text Regular", size: 13))
        }
        
        .onTapGesture(perform: {
            if (self.selectedImageName != nil) {
                self.shouldChangeImage.toggle()
                if self.shouldChangeImage {
                    self.number += 1
                } else {
                    self.number -= 1
                }
            } else {
                print("tapped comment")
            }
        })
    }
}

struct SingleActionView_Previews: PreviewProvider {
    static var previews: some View {
        SingleActionView(imageName: "Like", selectedImageName: "LikeSelected", selectedColor: .light_gray, shouldChangeImage: false, number: 20)
    }
}
