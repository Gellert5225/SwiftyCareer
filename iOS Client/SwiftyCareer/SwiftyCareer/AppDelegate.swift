//
//  AppDelegate.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import UIKit
import SCWebAPI

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
        
        if (User.current != nil) {
            self.window?.rootViewController = prepareDrawerMenu()
            self.window?.makeKeyAndVisible()
        } else {
            self.window?.rootViewController = landingView
            self.window?.makeKeyAndVisible()
        }
        
        let config = SCWebClientConfiguration(serverURL: ENV.SERVER_URL)
        SCWebClient.Initialize(with: config)
        window?.overrideUserInterfaceStyle = .dark  
//        let xhr = SCXHR()
//        
//        let signin = SCResource(path: "/api/rest/auth/signin", method: .POST, params: ["username": "jli542", "password": "5917738ljh"])
//        let jwt = SCResource(path: "/testCookieJwt")
////        let feeds = SCResource(path: "/feeds")
////        let image = SCResource(path: "/api/files/3d7fc74f01f7162fef98a1c145f15dfc.jpg")
//        let signup = SCResource(path: "/api/rest/auth/signup", method: .POST, params: ["username": "testios", "password": "12345", "email": "test@gmail.com"])
//        
//        xhr.request(resource: signup) { response in
//            if let error = response.err {
//                print("OOPS")
//                print(error)
//            }
//            if let res = response.res {
//                print(res)
//                print(response.cookie)
//            }
//        }
        
        
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
        
//        let query = PFQuery(className:"Feed")
//        query.getObjectInBackground(withId: "JQqwabXf9K") { (feed, error) in
//            if error == nil {
//                print("success!");
//                if let feed = feed {
//                    feed["numberOfLikes"] = 2
//                    feed.saveInBackground { (succeeded, error)  in
//                        if (succeeded) {
//                            print("saved");
//                        } else {
//                            // There was a problem, check error.description
//                            print("error when saving: \(error?.localizedDescription)")
//                        }
//                    }
//                }
//            } else {
//                print("error: \(error?.localizedDescription)")
//                // Fail!
//            }
//        }
//

        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor(red: 42.0/255, green: 47.0/255, blue: 63.0/255, alpha: 1.0)
        UITabBar.appearance().shadowImage = UIImage.colorForNavBar(color: UIColor.light_gray)
        
//        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
//        //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().backgroundColor = UIColor(red: 42.0/255, green: 47.0/255, blue: 63.0/255, alpha: 1.0)
//        //UINavigationBar.appearance().barTintColor = UIColor.background_color
//        UINavigationBar.appearance().standardAppearance.shadowColor = .white
//        UINavigationBar.appearance().isTranslucent = false
//        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBar.appearance().standardAppearance

        return true
    }

}

