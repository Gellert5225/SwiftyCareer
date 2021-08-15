//
//  DiscoverTableViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 11/20/20.
//

import UIKit

class JobTableViewController: SCTableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    var leftBarButtonItem: UIBarButtonItem?
    var rightBarButtonItem: UIBarButtonItem?
    
    var isSearching: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        leftBarButtonItem = self.navigationItem.leftBarButtonItem
        rightBarButtonItem = self.navigationItem.rightBarButtonItem
        
        searchController.searchResultsUpdater = self
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true

        // Don't hide the navigation bar because the search bar is in it.
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.delegate = self
        
        tableView.backgroundColor = .tableview_background
        tableView.separatorColor = .light_gray
        
        tableView.tableFooterView = UIView()
        
        let searchBarContainer = SearchBarContainerView(customSearchBar: searchController.searchBar, placeholderText: "Search Jobs")
        searchBarContainer.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 30)
        self.navigationItem.titleView = searchBarContainer
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
        //drawer()?.panGestureType = .none
//        if let searchText = searchController.searchBar.text {
//            if searchText != "" {
//                let query = PFQuery(className: "Feed")
//                //query.whereKey("username", matchesRegex: searchText, modifiers: "i")
//                query.whereKey("text", matchesText: searchText)
//                //query.whereKey("display_name", hasPrefix: searchText)
//                query.order(byAscending: "$score")
//                query.selectKeys(["$score"])
//                query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
//                    if let error = error {
//                        print(error.localizedDescription)
//                    } else if let objects = objects {
//                        print("found \(objects.count) users")
//                        objects.forEach { (object) in
//                            print("User \(object.objectId!) has \(object["score"] ?? "unknown") weight");
//                        }
//                    }
//                }
//            }
//        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.navigationItem.leftBarButtonItem = nil
            self.navigationItem.rightBarButtonItem = nil
            self.navigationController?.view.setNeedsLayout() // force update layout
            self.navigationController?.view.layoutIfNeeded() // to fix height of the navigation bar
        } completion: {finished in}

        return true
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        //drawer()?.panGestureType = .pan
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.navigationItem.leftBarButtonItem = self.leftBarButtonItem!
            self.navigationItem.rightBarButtonItem = self.rightBarButtonItem!
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


