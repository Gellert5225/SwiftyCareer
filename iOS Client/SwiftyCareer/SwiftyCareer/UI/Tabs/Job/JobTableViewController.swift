//
//  DiscoverTableViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 11/20/20.
//

import UIKit
import Parse

class JobTableViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    var leftBarButtonItem: UIBarButtonItem?
    var rightBarButtonItem: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        leftBarButtonItem = self.tabBarController?.navigationItem.leftBarButtonItem
        rightBarButtonItem = self.tabBarController?.navigationItem.rightBarButtonItem
        
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true

        // Don't hide the navigation bar because the search bar is in it.
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        
        tableView.backgroundColor = .tableview_background
        tableView.separatorColor = .light_gray
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchBarContainer = SearchBarContainerView(customSearchBar: searchController.searchBar, placeholderText: "Search Jobs")
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        self.tabBarController?.navigationItem.titleView = searchBarContainer
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            if searchText != "" {
                let query = PFQuery(className: "_User")
                query.whereKey("username", matchesRegex: searchText, modifiers: "i")
//                query.order(byAscending: "$score")
//                query.selectKeys(["$score"])
                query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let objects = objects {
                        print("found \(objects.count) users")
                        objects.forEach { (object) in
                            print("User \(object.objectId!) has \(object["score"] ?? "unknown") weight");
                        }
                    }
                }
            }
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.tabBarController?.navigationItem.leftBarButtonItem = nil
            self.tabBarController?.navigationItem.rightBarButtonItem = nil
            self.tabBarController?.navigationController?.view.setNeedsLayout() // force update layout
            self.tabBarController?.navigationController?.view.layoutIfNeeded() // to fix height of the navigation bar
        } completion: {finished in}

        return true
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.tabBarController?.navigationItem.leftBarButtonItem = self.leftBarButtonItem!
            self.tabBarController?.navigationItem.rightBarButtonItem = self.rightBarButtonItem!
//            self.tabBarController?.navigationController?.view.setNeedsLayout() // force update layout
//            self.tabBarController?.navigationController?.view.layoutIfNeeded() // to fix height of the navigation bar
        } completion: {finished in}
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


