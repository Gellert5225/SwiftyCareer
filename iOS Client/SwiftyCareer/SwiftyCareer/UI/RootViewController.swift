//
//  RootViewController.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import UIKit
import SCWebAPI
import Network

class RootViewController: UITabBarController, UITabBarControllerDelegate, NetworkReachabilityObserver {
    
    var networkCheck = NetworkReachability.sharedInstance()
    func statusDidChange(status: NWPath.Status) {
        if status == .satisfied {
            print("internet resumed")
        }else if status == .unsatisfied {
            self.present(showStandardDialog(title: "Error", message: "No Internet Connection", defaultButton: "OK", defaultButtonAction: {}), animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        networkCheck.addObserver(observer: self)
        
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
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ComposeViewController")
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true, completion: nil)
            return false
        }

        return true
    }
}
