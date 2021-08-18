//
//  SCTableViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 11/23/20.
//

import UIKit
import SCWebAPI

class SCTableViewController: UITableViewController, PZPullToRefreshDelegate, SCNavigationBarButtonDelegate {
    
    var viewModel: SCViewModel
        
    var refreshView: PZPullToRefreshView?
    
    var leftButton: SCNavigationBarButton?
    var rightButton: SCNavigationBarButton?
    
    init(viewModel: SCViewModel) {
        self.viewModel = viewModel
        
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        //print(User.current)
                
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: "LoadingCell", bundle: nil), forCellReuseIdentifier: "LoadingCell")
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.backgroundColor = .tableview_background
        tableView.separatorColor = .light_gray
        
        tableView.tableFooterView = UIView()
        
        leftButton = SCNavigationBarButton(on: .left)
        rightButton = SCNavigationBarButton(on: .right)
        leftButton?.delegate = self
        rightButton?.delegate = self
        self.navigationItem.leftBarButtonItem = leftButton
        self.navigationItem.rightBarButtonItem = rightButton
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(red: 42.0/255, green: 47.0/255, blue: 63.0/255, alpha: 1.0)
        self.navigationController?.navigationBar.standardAppearance = appearance;
        self.navigationController?.navigationBar.scrollEdgeAppearance = self.navigationController?.navigationBar.standardAppearance
    }
    
    func fetchData() {
        viewModel.fetch { (feeds: [SCObject]?, error: Error?) in
            if let err = error as? SCServiceError {
                print(err.localizedDescription)
                self.viewModel.isLoading = false
                self.present(showStandardDialog(title: "Error", message: err.localizedDescription, defaultButton: "OK", defaultButtonAction: {
                    if (400..<500) ~= err.errorCode! {
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let landingView = storyboard.instantiateViewController(withIdentifier: "landingVC") as! LandingViewController
                        landingView.modalPresentationStyle = .fullScreen
                        self.present(landingView, animated: true, completion:nil)
                    }
                }), animated: true, completion: nil)
            }
            self.tableView.reloadData()
            if self.refreshView == nil {
                let view = PZPullToRefreshView(frame: CGRect(x: 0, y: -40, width: self.tableView.bounds.size.width, height: 40))
                view.delegate = self
                self.tableView.addSubview(view)
                self.refreshView = view
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.isLoading ? 1 : viewModel.objects.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.isLoading ? 44.0 : UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isLoading {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            cell.textLabel?.text = ""
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
        
        viewModel.fetch { (feeds: [SCObject]?, error: Error?) in
            if let err = error as? SCServiceError {
                print(err.localizedDescription)
                self.present(showStandardDialog(title: "Error", message: err.localizedDescription, defaultButton: "OK", defaultButtonAction: {
                    if (400..<500) ~= err.errorCode! {
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let landingView = storyboard.instantiateViewController(withIdentifier: "landingVC") as! LandingViewController
                        landingView.modalPresentationStyle = .fullScreen
                        self.present(landingView, animated:true, completion:nil)
                    }
                }), animated: true, completion: nil)
            } else {
                print("Complete loading!")
                self.refreshView?.isLoading = false
                self.tableView.reloadData()
            }
            self.refreshView?.refreshScrollViewDataSourceDidFinishedLoading(self.tableView, .zero)
        }
    }
    
    func barButtonTappedOn(_ side: DrawerMenu.Side) {
        drawer()?.open(to: side)
    }

}
