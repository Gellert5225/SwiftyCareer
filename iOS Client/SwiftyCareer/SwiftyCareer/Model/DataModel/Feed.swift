//
//  Feed.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/17/20.
//

import Foundation
import SCWebAPI

class Feed: SCObject {
    var author: User
    var created_at: Double
    var text: String
    var text_JSON: String
    var images: [String]
    var like_count: Int
    var comment_count: Int
    var share_count: Int
    var liked_user_ids: [String]
    
    init(from feedJSON: JSON) {
        self.author = User(from: feedJSON["author"] as! JSON)
        self.created_at = feedJSON["created_at"] as! Double
        self.text = feedJSON["text"] as! String
        self.text_JSON = feedJSON["text_JSON"] as! String
        self.images = feedJSON["images"] as! [String]
        self.like_count = feedJSON["like_count"] as! Int
        self.comment_count = feedJSON["comment_count"] as! Int
        self.share_count = feedJSON["share_count"] as! Int
        self.liked_user_ids = feedJSON["liked_user_ids"] as! [String]
        
        super.init()
        self._id = feedJSON["_id"] as? String
    }
    
    func like(with amount: Int) {
        let like = SCResource(path: "/feeds/\(_id!)/likes", method: .PUT, params: ["userId" : User.current!._id!, "amount": amount])
        SCXHR().request(resource: like) { response in
            if let error = response.err {
                print(error)
                //self.present(showStandardDialog(title: "Error", message: error.localizedDescription, defaultButton: "OK"), animated: true, completion: nil)
            }
            if let _ = response.res {
                if let error = response.err {
                    print(error)
                    //self.present(showStandardDialog(title: "Error", message: error.localizedDescription, defaultButton: "OK"), animated: true, completion: nil)
                } else {
//                    UserDefaults.standard.set(response.cookie![0].value, forKey: response.cookie![0].name)
//                    if let userJSON = res["info"] as? JSON {
//                        print(userJSON)
//                        UserDefaults.standard.set(jsonToString(json: userJSON), forKey: "currentUser")
//                    }
                    //self.present(prepareDrawerMenu(), animated:true, completion: nil)
                }
            }
        }
    }
    
}

