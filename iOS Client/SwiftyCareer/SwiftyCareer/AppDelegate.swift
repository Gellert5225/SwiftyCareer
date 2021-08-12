//
//  AppDelegate.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import UIKit
import Parse
import SCWebAPI
import Network

@main
class AppDelegate: UIResponder, UIApplicationDelegate, NetworkReachabilityObserver {
    var networkCheck = NetworkReachability.sharedInstance()
    func statusDidChange(status: NWPath.Status) {
        if status == .satisfied {
            print("internet resumed")
        }else if status == .unsatisfied {
            print("internet interrupted")
        }
    }
    
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        #if DEBUG
            print("Running on DEBUG")
        #elseif RELEASE
            print("Running on RELEASE")
        #endif
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        networkCheck.addObserver(observer: self)
        
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
        
        let config = SCWebAPIConfiguration(serverURL: "http://192.168.1.16:1336")
        SCWebAPI.Initialize(with: config)
        
        let xhr = SCXHR()
        
        let signin = SCResource(path: "/api/rest/auth/signin", method: .POST, params: ["username": "d_schrute", "password": "5917738ljh"])
        let jwt = SCResource(path: "/testCookieJwt")
        
        xhr.request(resource: jwt) {response in
            if let error = response.err {
                print("OOPS")
                print(error)
            }
            
            print(response)
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
//        let parameters = ["username": "jli542", "password": "5917738ljh"] as [String : Any]
//
//        //create the url with URL
//        let url = URL(string: "http://192.168.1.16:1336/testCookieJwt")! //change the url
//        //let url = URL(string: "http://192.168.1.16:1336/api/rest/auth/signin")!
//        //create the session object
//        let session = URLSession.shared
//
//        let jar = HTTPCookieStorage.shared
//        let cookieHeaderField = ["Set-Cookie": "user_jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxMGYyMzZlMWI1MTE5ZjlkYWU1OTUzNSIsImlhdCI6MTYyODM5NDUyNywiZXhwIjoxNjI4Mzk0NTU3fQ.5ZAyf8ilCP-d6CXcsidYiKELNWED4C28YGZoIdw4PEM"] // Or ["Set-Cookie": "key=value, key2=value2"] for multiple cookies
//        let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: url)
//        //jar.setCookies(cookies, for: url, mainDocumentURL: url)
//
//        //now create the URLRequest object using the url object
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET" //set http method as POST
//
//        do {
//            //request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
//        } catch let error {
//            print(error.localizedDescription)
//        }
//
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//        //create dataTask using the session object to send data to the server
//        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
//
//            guard error == nil else {
//                return
//            }
//
//            guard let data = data else {
//                return
//            }
//            print(response)
//
//            do {
//                //create json object from data
//                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
//                    print(json)
//                    let cookieStorage = HTTPCookieStorage.shared
//                    let cookies = cookieStorage.cookies(for: url) ?? []
//                    print(cookies)
//                    // handle json...
//                }
//            } catch let error {
//                print(error.localizedDescription)
//            }
//        })
//        task.resume()
        
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

