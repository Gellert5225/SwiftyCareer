//
//  FeedTableViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/16/20.
//

import UIKit
import Parse

class FeedTableViewController: SCTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Feed"
        self.tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "FeedCell")
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as! FeedCell
            let feed = viewModel.objects[indexPath.row]
            
            cell.feed = feed as! Feed

            return cell
        }
    }
    
}
