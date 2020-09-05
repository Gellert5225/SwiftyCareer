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
            FeedUserTitleView()
            
            FeedTextView(feed)
        }
        .listRowBackground(Color.dark)
    }
}

struct FeedRow_Previews: PreviewProvider {
    static var previews: some View {
        FeedRow(feed: Feed(id: 1, userName: "G", bio: "G", text: "G"))
        
    }
}
