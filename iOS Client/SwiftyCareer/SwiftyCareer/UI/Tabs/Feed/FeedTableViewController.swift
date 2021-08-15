//
//  FeedTableViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/16/20.
//

import UIKit

class FeedTableViewController: SCTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Feed"
        self.tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
        self.tableView.register(UINib(nibName: "FeedCellNoImage", bundle: nil), forCellReuseIdentifier: "FeedCellNoImage")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            
            return cell
        } else {
            let feed = viewModel.objects[indexPath.row] as! Feed
            if feed.images!.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
                
                cell.feed = feed

                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCellNoImage", for: indexPath) as! FeedCellNoImage
                
                cell.feed = feed

                return cell
            }
        }
    }
    
}
