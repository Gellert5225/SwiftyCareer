//
//  RootViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import UIKit

class RootViewController: UITabBarController, UITabBarControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        createTabBarController()
        buildBarButtonItems()
    }
    
    @objc func presentLeftMenu() {
        print("present left menu")
        drawer()?.open(to: .left)
    }
    
    @objc func presentChat() {
        print("present chat")
        drawer()?.open(to: .right)
    }
    
    func buildBarButtonItems() {
        var profileImage = UIImage(named: "Gellert")?.roundedImageWithBorder(width: 1, color: .light_gray)
        profileImage = profileImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: profileImage, style: .plain, target: self, action: #selector(presentLeftMenu))
        
        var rightBarImage = UIImage(named: "ChatRed")
        rightBarImage = rightBarImage?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightBarImage, style: .plain, target: self, action: #selector(presentChat))
    }
    
    func createTabBarController() {
        
        let feedVC = FeedTableViewController(viewModel: FeedViewModel(), navigationTitle: "Feed")
        feedVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal))
        
        let discoverVC = JobTableViewController()
        discoverVC.restorationIdentifier = "discover"
        discoverVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Job")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "JobSelected")?.withRenderingMode(.alwaysOriginal))
        
        let composeVC = UIViewController()
        composeVC.restorationIdentifier = "compose"
        composeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Write")?.withRenderingMode(.alwaysOriginal), tag: 2)
        
        let connectionVC = UIViewController()
        connectionVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Friends")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "FriendsSelected")?.withRenderingMode(.alwaysOriginal))
        
        let notificationVC = UIViewController()
        notificationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Alert")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "AlertSelected")?.withRenderingMode(.alwaysOriginal))
        
        viewControllers = [feedVC, discoverVC, composeVC, connectionVC, notificationVC]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let identifier = viewController.restorationIdentifier, identifier == "compose" {
            let vc = UIViewController()
            vc.view.backgroundColor = .blue
            present(vc, animated: true, completion: nil)
            return false
        }
//        if let identifier = viewController.restorationIdentifier, identifier == "discover" {
//            self.navigationItem.leftBarButtonItem = nil
//            self.navigationItem.rightBarButtonItem = nil
//        } else {
//             buildBarButtonItems()
//        }
        
        buildBarButtonItems()

        return true
    }
}
