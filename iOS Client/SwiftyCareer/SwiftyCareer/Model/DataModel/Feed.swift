//
//  Feed.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/17/20.
//

import Foundation
import SCWebAPI

class Feed: SCObject {
    var author: User?
    var created_at: Double?
    var text: String?
    var text_JSON: String?
    var images: [String]?
    var like_count: Int?
    var comment_count: Int?
    var share_count: Int?
    var liked_user_ids: [String]?
    
    init(from feedJSON: JSON) {
        self.author = User(from: feedJSON["author"] as! JSON)
        self.created_at = feedJSON["created_at"] as? Double
        self.text = feedJSON["text"] as? String
        self.text_JSON = feedJSON["text_JSON"] as? String
        self.images = feedJSON["images"] as? [String]
        self.like_count = feedJSON["like_count"] as? Int
        self.comment_count = feedJSON["comment_count"] as? Int
        self.share_count = feedJSON["share_count"] as? Int
        self.liked_user_ids = feedJSON["liked_use_ids"] as? [String]
        
        super.init()
        self._id = feedJSON["_id"] as? String
    }
    
}

