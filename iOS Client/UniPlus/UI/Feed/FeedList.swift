//
//  FeedList.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedList: View {
    var feeds = generateFeed()
    @ObservedObject var model = MyModel()
    
    var view = PZPullToRefreshView(frame: CGRect(x: 0, y: -100, width: 100, height: 100))
    
    var body: some View {
        GeometryReader{ geometry in
            RefreshScrollView(width: geometry.size.width, height: geometry.size.height, pz: PZPullToRefreshView(frame: CGRect(x: 0, y: 0 - geometry.size.height, width: geometry.size.width, height: geometry.size.height)), handlePullToRefresh: {
                print("handle")
               
            
            }) {
                ScrollView(.vertical) {
                    ForEach(0..<self.feeds.count, id:\.self) { i in
                        FeedRow(feed: self.feeds[i])
                    }
                    .listRowBackground(Color.dark)
                }
                .onAppear() {
                    UITableView.appearance().backgroundColor = UIColor.tableview_background
                        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
                }
                .background(Color.background_color)
                .listStyle(GroupedListStyle())
            }
        }
    }
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        FeedList()
    }
}
