//
//  Feed.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/17/20.
//

import Foundation
import Parse

class Feed: SCObject {
    var user: PFUser?
    var text: String?
    var images: [PFFileObject]?
    var numberOfLikes: Int?
    var numberOfComments: Int?
    var numberOfShares: Int?
    var numberOfImages: Int?
    //var comments: [Comment]
    var isLikedByCurrentUser: Bool?
    
    override init() {
        
    }
    
    init(id: String, parseObject: PFObject? = nil, user: PFUser, text: String = "", images: [PFFileObject], numberOfLikes: Int, numberOfComments: Int, numberOfShares: Int, numberOfImages: Int, isLikedByCurrentUser: Bool) {
        super.init()
        
        self.id = id
        self.parseObject = parseObject
        self.user = user
        self.text = text
        self.images = images
        self.numberOfLikes = numberOfLikes
        self.numberOfComments = numberOfComments
        self.numberOfShares = numberOfShares
        self.numberOfImages = numberOfImages
        self.isLikedByCurrentUser = isLikedByCurrentUser
    }
}

