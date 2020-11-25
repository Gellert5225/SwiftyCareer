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
    }
    
    func createTabBarController() {
        
        let feedVC = FeedTableViewController(viewModel: FeedViewModel())
        feedVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "HomeSelected")?.withRenderingMode(.alwaysOriginal))
        
        let jobVC = JobTableViewController(viewModel: SCViewModel())
        jobVC.restorationIdentifier = "discover"
        jobVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Job")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "JobSelected")?.withRenderingMode(.alwaysOriginal))
        
        let composeVC = UIViewController()
        composeVC.restorationIdentifier = "compose"
        composeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Write")?.withRenderingMode(.alwaysOriginal), tag: 2)
        
        let connectionVC = UIViewController()
        connectionVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Friends")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "FriendsSelected")?.withRenderingMode(.alwaysOriginal))
        
        let notificationVC = UIViewController()
        notificationVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Alert")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "AlertSelected")?.withRenderingMode(.alwaysOriginal))
        
        viewControllers = [UINavigationController(rootViewController:feedVC),
                           UINavigationController(rootViewController:jobVC),
                           composeVC,
                           UINavigationController(rootViewController:connectionVC),
                           UINavigationController(rootViewController:notificationVC)]
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if let identifier = viewController.restorationIdentifier, identifier == "compose" {
            let vc = UIViewController()
            vc.view.backgroundColor = .blue
            present(vc, animated: true, completion: nil)
            return false
        }

        return true
    }
}
