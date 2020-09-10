//
//  FeedList.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedList: View {
    @State var feedModel: FeedModel = FeedModel(modelData: generateFeed("Gellert"))
    
    var view = PZPullToRefreshView(frame: CGRect(x: 0, y: -100, width: 100, height: 100))
    
    func handlePullToRefresh() {
        //print(feedModel.modelData)
    }
    
    var body: some View {
        GeometryReader{ geometry in
            RefreshScrollView(feeds: $feedModel, width: geometry.size.width, height: geometry.size.height, pz: PZPullToRefreshView(frame: CGRect(x: 0, y: 0 - geometry.size.height, width: geometry.size.width, height: geometry.size.height)), handlePullToRefresh: handlePullToRefresh) {
                SwiftUIList(model: self.feedModel)
            }
        }
    }
}

struct SwiftUIList: View {
        
    @ObservedObject var model: FeedModel

    var body: some View {
        ScrollView(.vertical) {
            ForEach(0..<self.model.modelData.count, id:\.self) { i in
                FeedRow(feed: self.model.modelData[i])
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

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedList()
        }
    }
}
