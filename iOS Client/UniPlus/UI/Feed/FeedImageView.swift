//
//  FeedImageView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/8/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedImageView: View {
    @State var index = 0

    var images: [Image]
    
    var body: some View {
        VStack {
            PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                ForEach(0...self.images.count - 1, id: \.self) {
                    self.images[$0]
                        .resizable()
                        .scaledToFill()
                }
            }
            .aspectRatio(4/3, contentMode: .fit)
            //.clipShape(RoundedRectangle(cornerRadius: 15))
        }
    }
}

struct FeedImageView_Previews: PreviewProvider {
    static var previews: some View {
        FeedImageView(images: [Image("sample1"), Image("sample2"), Image("sample3"), Image("sample4"), Image("sample5")])
    }
}
