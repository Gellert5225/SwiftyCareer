//
//  AppDelegate.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if DEBUG
            print("Running on DEBUG")
        #elseif RELEASE
            print("Running on RELEASE")
        #endif
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let landingView = storyboard.instantiateViewController(withIdentifier: "landingVC") as! LandingViewController
        
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = ENV.APP_ID
            $0.server = ENV.SERVER_URL
        }
        Parse.initialize(with: parseConfig)
        
        if (PFUser.current() != nil) {
            self.window?.rootViewController = prepareDrawerMenu()
            self.window?.makeKeyAndVisible()
        } else {
            self.window?.rootViewController = landingView
            self.window?.makeKeyAndVisible()
        }
        
//        PFCloud.callFunction(inBackground: "SendTestEmail", withParameters: nil) { (response, error) in
//            print(response)
//        }
        
//        let query = PFQuery(className: "_User")
//        query.whereKey("display_name", matchesText: "Li")
//        query.order(byAscending: "$score")
//        query.selectKeys(["$score"])
//        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let objects = objects {
//                print("found \(objects.count) users")
//                objects.forEach { (object) in
//                    print("User \(object.objectId!) has \(object["score"] ?? "unknown") weight");
//                }
//            }
//        }
        
//        let query = PFQuery(className: "_User")
//        query.whereKey("display_name", matchesRegex: "g", modifiers: "i")
//        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else if let objects = objects {
//                print("found \(objects.count) users")
//                objects.forEach { (object) in
//                    print("User \(object.objectId!) has \(object["score"] ?? "unknown") weight");
//                }
//            }
//        }
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(red: 42.0/255, green: 47.0/255, blue: 63.0/255, alpha: 1.0)
        UITabBar.appearance().shadowImage = UIImage.colorForNavBar(color: UIColor.light_gray)
        
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        //UINavigationBar.appearance().backgroundColor = UIColor(red: 42.0/255, green: 47.0/255, blue: 63.0/255, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = UIColor.background_color
        UINavigationBar.appearance().standardAppearance.shadowColor = .white
        UINavigationBar.appearance().isTranslucent = false

        return true
    }

}

