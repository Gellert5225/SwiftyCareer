//
//  FeedViewModel.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/17/20.
//

import Foundation
import Parse

class FeedViewModel: SCViewModel {
    
    override func fetch(onCompletion complete: @escaping ([SCObject]?, Error?) -> Void) {
        PFCloud.callFunction(inBackground: "FetchFeeds", withParameters: nil) { (objects, error) in
            if let err = error {
                self.isLoading = false
                complete(nil, err)
            } else if let feeds = objects as? [PFObject] {
                self.objects = []
                for object in feeds {
                    var imageDatas: [PFFileObject] = []
                    for imageObject in object["images"] as! [PFObject] {
                        imageDatas.append(imageObject["image"] as! PFFileObject)
                    }
                    let likedUserIds = object["likedUserIds"] as! [String]
                    let feed = Feed(id: object.objectId!,
                                    user: object["author"] as! PFUser,
                                    text: object["text"] as! String,
                                    images: imageDatas,
                                    numberOfLikes: object["numberOfLikes"] as! Int,
                                    numberOfComments: object["numberOfComments"] as! Int,
                                    numberOfShares: object["numberOfShares"] as! Int,
                                    numberOfImages: imageDatas.count,
                                    isLikedByCurrentUser: likedUserIds.contains((PFUser.current()?.objectId)!))
                    self.objects.append(feed)
                }
                self.isLoading = false
                complete(self.objects, nil)
            }
        }
    }
}
