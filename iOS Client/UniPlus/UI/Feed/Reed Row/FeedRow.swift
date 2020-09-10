//
//  FeedRow.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedRow: View {
    var feed: Feed
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            FeedUserTitleView(name: feed.userName)
                .padding(10)
            
            FeedTextView(self.feed)
                .padding([.leading, .trailing], 10)
            
            FeedImageView(images: [Image("sample1"), Image("sample2"), Image("sample3"), Image("sample4"), Image("sample5")])
            
            FeedActionView()
            
            ExDivider()
        }
        .listRowBackground(Color.dark)
    }
}

struct FeedRow_Previews: PreviewProvider {
    static var previews: some View {
        FeedRow(feed: Feed(userName: "G", bio: "G", text: "G"))
        
    }
}

struct ExDivider: View {
    let color: Color = .light_gray
    let width: CGFloat = 0.5
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
            .edgesIgnoringSafeArea(.horizontal)
    }
}
