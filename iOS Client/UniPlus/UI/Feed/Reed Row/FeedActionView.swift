//
//  FeedActionView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/9/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedActionView: View {
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            
            SingleActionView(imageName: "Like", selectedImageName: "LikeSelected", selectedColor: .like_selected_color, shouldChangeImage: false, number: 20)
            Spacer()
            
            SingleActionView(imageName: "Comment", selectedImageName: nil, selectedColor: .light_gray, shouldChangeImage: false, number: 50)
            Spacer()
            
            SingleActionView(imageName: "Repost", selectedImageName: "RepostSelected", selectedColor: .tint_color, shouldChangeImage: false, number: 2)
            
            Spacer()
        }
        
    }
}

struct FeedActionView_Previews: PreviewProvider {
    static var previews: some View {
        FeedActionView()
    }
}
