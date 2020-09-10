//
//  PullToRefresh.swift
//  UniPlus
//
//  Created by Gellert Li on 9/5/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct RefreshScrollView<Content: View>: UIViewRepresentable{
    
    @Binding var feeds: FeedModel
    var width : CGFloat, height : CGFloat
    var pz: PZPullToRefreshView
    let handlePullToRefresh: () -> Void
    var content: () -> Content
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, data: $feeds, pz: pz, scroll: UIScrollView(), content: content(), handlePullToRefresh: handlePullToRefresh)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let view = pz
        view.delegate = context.coordinator
        view.bgColor = UIColor.tableview_background
        view.statusTextColor = UIColor.light_gray
        
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.removeFromSuperview()
        control.addSubview(view)
        control.refreshControl?.backgroundColor = UIColor.tableview_background
        let childView = UIHostingController(rootView: content())
        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        control.delegate = context.coordinator
        control.addSubview(childView.view)
        
        return control
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {
        context.coordinator.update(content: content())
    }

    class Coordinator: NSObject, UIScrollViewDelegate, PZPullToRefreshDelegate {
        
        var control: RefreshScrollView
        @Binding var feeds: FeedModel
        var pz: PZPullToRefreshView
        var scroll: UIScrollView
        var handlePullToRefresh: () -> Void
        let rootViewController: UIHostingController<Content>

        init(_ control: RefreshScrollView, data: Binding<FeedModel>, pz: PZPullToRefreshView, scroll: UIScrollView, content: Content, handlePullToRefresh: @escaping () -> Void) {
            rootViewController = UIHostingController(rootView: content)
            self.control = control
            _feeds = data
            self.handlePullToRefresh = handlePullToRefresh
            self.pz = pz
            self.scroll = scroll
            self.pz.scrollView = scroll
        }
        
        func update(content: Content) {
            rootViewController.rootView = content
            rootViewController.view.setNeedsDisplay()
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.scroll = scrollView
            pz.refreshScrollViewDidScroll(scrollView)
        }
        
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            pz.refreshScrollViewDidEndDragging(scrollView)
        }
        
        func pullToRefreshDidTrigger(_ view: PZPullToRefreshView) {
            view.scrollView = self.scroll
            view.isLoading = true

            self.feeds.addElement("Cindy Li", onSuccess: {
                print("Complete loading!")
                view.isLoading = false
                view.refreshScrollViewDataSourceDidFinishedLoading()
                self.handlePullToRefresh()
            })
        }
    }
}
