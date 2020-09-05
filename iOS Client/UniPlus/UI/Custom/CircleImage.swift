//
//  CircleImage.swift
//  UniPlus
//
//  Created by Gellert Li on 9/2/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        image
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipped()
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.light_gray, lineWidth: 1))
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("Gellert"), width: 30, height: 30)
    }
}
