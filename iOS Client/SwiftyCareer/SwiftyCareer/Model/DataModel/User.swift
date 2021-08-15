//
//  User.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/17/20.
//

import Foundation
import SCWebAPI

class User: SCObject {
    static var current: JSON? {
        get {
            if let currentUserStr = UserDefaults.standard.string(forKey: "currentUser") {
                return stringToJSON(string: currentUserStr)
            }
            return nil
        }
    }
    
    var display_name: String
    var bio: String
    var position: String
    var profile_picture: String
        
    init(from userJSON: JSON) {
        self.display_name = userJSON["display_name"] as! String
        self.bio = userJSON["bio"] as! String
        self.position = userJSON["position"] as! String
        self.profile_picture = userJSON["profile_picture"] as! String
        
        super.init()
        self._id = userJSON["_id"] as? String
    }
}
