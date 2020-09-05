//
//  FeedList.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedList: View {
    var body: some View {
        List {
            ForEach(0..<10, id: \.self) { _ in
                FeedRow()
            }
        }
        .onAppear() {
                UITableView.appearance().backgroundColor = .clear
                UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        }
        .background(BACKGROUND_COLOR)
        .listStyle(GroupedListStyle())
    }
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList()
    }
}
