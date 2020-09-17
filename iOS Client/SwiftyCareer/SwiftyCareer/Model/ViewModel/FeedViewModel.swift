//
//  FeedViewModel.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/17/20.
//

import Foundation
import Parse

class FeedViewModel {
    var feeds: [Feed] = []
    var isLoading = true
    
    func fetchFeeds(onCompletion complete: @escaping ([Feed]?, Error?) -> Void) {
        PFCloud.callFunction(inBackground: "FetchFeeds", withParameters: nil) { (objects, error) in
            if let err = error {
                print(err.localizedDescription)
                self.isLoading = false
                complete(nil, err)
            } else if let feeds = objects as? [PFObject] {
                self.feeds = []
                for object in feeds {
                    let likedUserIds = object["likedUserIds"] as! [String]
                    let feed = Feed(user: object["author"] as! PFUser,
                                    text: object["text"] as! String,
                                    images: object["images"] as! [PFFileObject],
                                    numberOfLikes: object["numberOfLikes"] as! Int,
                                    numberOfComments: object["numberOfComments"] as! Int,
                                    numberOfShares: object["numberOfShares"] as! Int,
                                    isLikedByCurrentUser: likedUserIds.contains((PFUser.current()?.objectId)!))
                    self.feeds.append(feed)
                }
                self.isLoading = false
                complete(self.feeds, nil)
            }
        }
    }
}
