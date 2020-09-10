//
//  FeedList.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedList: View {
    @State var feedModel: FeedModel = FeedModel()
    
    @State var isLoading = true
        
    func handlePullToRefresh() {
        //print(feedModel.modelData)
    }
    
    var body: some View {
        GeometryReader{ geometry in
            RefreshScrollView(feeds: self.$feedModel, width: geometry.size.width, height: geometry.size.height, pz: PZPullToRefreshView(frame: CGRect(x: 0, y: 0 - geometry.size.height, width: geometry.size.width, height: geometry.size.height)), handlePullToRefresh: self.handlePullToRefresh) {
                SwiftUIList(model: self.feedModel)
            }
            .onAppear {
                self.feedModel.addElement("Gellert Li", onSuccess: {
                                            print("Suceess")
                                            self.isLoading.toggle() })
            }
        }
    }
}

struct SwiftUIList: View {
        
    @ObservedObject var model: FeedModel

    var body: some View {
        ZStack {
            Color.background_color.edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical) {
                if (self.model.modelData.count == 0) {
                    Text("Loading")
                        .frame(width: 100, height: 50, alignment: .center)
                } else {
                    ForEach(0..<self.model.modelData.count, id:\.self) { i in
                        FeedRow(feed: self.model.modelData[i])
                    }
                    .listRowBackground(Color.dark)
                }
                
            }
            .onAppear() {
                //UIScrollView.appearance().backgroundColor = UIColor.tableview_background

            }
            .background(Color.background_color)
            .listStyle(GroupedListStyle())
        }
    }
}

struct FeedList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FeedList()
        }
    }
}
