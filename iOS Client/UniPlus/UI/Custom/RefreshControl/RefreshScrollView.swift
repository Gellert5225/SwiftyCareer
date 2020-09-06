//
//  PullToRefresh.swift
//  UniPlus
//
//  Created by Gellert Li on 9/5/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct RefreshScrollView<ROOTVIEW>: UIViewRepresentable where ROOTVIEW: View {
    
    var width : CGFloat, height : CGFloat
    var pz: PZPullToRefreshView
    let handlePullToRefresh: () -> Void
    let rootView: () -> ROOTVIEW
    
    func makeCoordinator() -> Coordinator<ROOTVIEW> {
        Coordinator(self, pz: pz, scroll: UIScrollView(), rootView: rootView, handlePullToRefresh: handlePullToRefresh)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let view = pz
        //pz.frame = CGRect(x: 0, y: 0 - height, width: width, height: height)
        view.delegate = context.coordinator
        view.bgColor = UIColor.tableview_background
        view.statusTextColor = UIColor.light_gray
        
        let control = UIScrollView()
        control.refreshControl = UIRefreshControl()
        control.refreshControl?.removeFromSuperview()
        control.addSubview(view)
        //control.refreshControl?.addSubview(pz)
        //control.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.pullToRefreshDidTrigger), for: .valueChanged)
        control.refreshControl?.backgroundColor = UIColor.tableview_background
        let childView = UIHostingController(rootView: rootView() )
        childView.view.frame = CGRect(x: 0, y: 0, width: width, height: height)
        control.delegate = context.coordinator
        control.addSubview(childView.view)
        //childView.view.addSubview(view)
        
        return control
    }

    func updateUIView(_ uiView: UIScrollView, context: Context) {}

    class Coordinator<ROOTVIEW>: NSObject, UIScrollViewDelegate, PZPullToRefreshDelegate where ROOTVIEW: View {
        func pullToRefreshDidTrigger(_ view: PZPullToRefreshView) {
            view.isLoading = true
            let whenWhen = DispatchTime.now() + DispatchTimeInterval.seconds(2)
            DispatchQueue.main.asyncAfter(deadline: whenWhen) {
                print("Complete loading!")
                view.isLoading = false
                view.refreshScrollViewDataSourceDidFinishedLoading(self.scroll, .zero)
           }
        }
        
        var control: RefreshScrollView
        var pz: PZPullToRefreshView
        var scroll: UIScrollView
        var handlePullToRefresh: () -> Void
        var rootView: () -> ROOTVIEW

        init(_ control: RefreshScrollView, pz: PZPullToRefreshView, scroll: UIScrollView, rootView: @escaping () -> ROOTVIEW, handlePullToRefresh: @escaping () -> Void) {
            self.control = control
            self.handlePullToRefresh = handlePullToRefresh
            self.rootView = rootView
            self.pz = pz
            self.scroll = scroll
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            self.scroll = scrollView
            pz.refreshScrollViewDidScroll(scrollView)
        }
        func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
            pz.refreshScrollViewDidEndDragging(scrollView)
        }
        
        @objc func handleRefreshControl(sender: UIRefreshControl) {

            sender.endRefreshing()
            handlePullToRefresh()
           
        }
    }
}
