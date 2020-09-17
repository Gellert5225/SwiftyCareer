//
//  User.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/17/20.
//

import Foundation
import Parse

class User: PFUser {
    @NSManaged var displayName: String
    @NSManaged var bio: String
    @NSManaged var position: String
}
