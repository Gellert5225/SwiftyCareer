//
//  FeedTableViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/16/20.
//

import UIKit
import Parse

class FeedTableViewController: UITableViewController, PZPullToRefreshDelegate {
    
    var feedModel = FeedViewModel()
    
    var refreshView: PZPullToRefreshView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedModel.fetchFeeds { (feeds: [Feed]?, error: Error?) in
            if let err = error {
                print(err.localizedDescription)
            } else {
                self.tableView.reloadData()
                if self.refreshView == nil {
                    let view = PZPullToRefreshView(frame: CGRect(x: 0, y: 0 - self.tableView.bounds.size.height, width: self.tableView.bounds.size.width, height: self.tableView.bounds.size.height))
                    view.delegate = self
                    self.tableView.addSubview(view)
                    self.refreshView = view
                }
            }
        }
        
        self.tabBarController?.title = "Feed"
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        self.tableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = .tableview_background
        tableView.separatorColor = .light_gray
        
        tableView.tableFooterView = UIView()

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedModel.isLoading ? 1 : feedModel.feeds.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return feedModel.isLoading ? 44.0 : UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if feedModel.isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
            let feed = feedModel.feeds[indexPath.row]
            
            cell.feed = feed

            return cell
        }
    }
    
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        refreshView?.refreshScrollViewDidScroll(scrollView)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        refreshView?.refreshScrollViewDidEndDragging(scrollView)
    }
    
    func pullToRefreshDidTrigger(_ view: PZPullToRefreshView) -> () {
        refreshView?.isLoading = true
        
        feedModel.fetchFeeds { (feeds: [Feed]?, error: Error?) in
            print("Complete loading!")
            self.refreshView?.isLoading = false
            self.refreshView?.refreshScrollViewDataSourceDidFinishedLoading(self.tableView, .zero)
            self.tableView.reloadData()
        }
    }
    
}
