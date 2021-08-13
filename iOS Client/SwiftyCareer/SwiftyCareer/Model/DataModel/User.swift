//
//  User.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/17/20.
//

import Foundation
import SCWebAPI

class User: SCObject {
    var display_name: String
    var bio: String
    var position: String
        
    init(from userJSON: JSON) {
        self.display_name = userJSON["display_name"] as! String
        self.bio = userJSON["bio"] as! String
        self.position = userJSON["position"] as! String
        
        super.init()
        self._id = userJSON["_id"] as? String
    }
}
