//
//  DummyFeeder.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/16/20.
//

import UIKit

class DummyFeed {
    var user: DummyUser
    var text: String
    var images: [UIImage]
    var likedByCurrentUser = false
    
    init(withUser user: DummyUser, feedText text: String, feedImages images: [UIImage]) {
        self.user = user
        self.text = text
        self.images = images
    }
}

class DummyUser {
    var username: String
    var bio: String
    var profilePicture: UIImage
    
    init(withUsername username: String, bio: String, profilePicture: UIImage) {
        self.username = username
        self.bio = bio
        self.profilePicture = profilePicture
    }
}

class DummyFeedModel {
    var modelData: [DummyFeed] = []
    var isLoading = true 
    
    func addElement(_ name: String, onSuccess success: @escaping () -> Void) {
        var dummy: [DummyFeed] = []

        DispatchQueue.global(qos: .background).async {
            dummy = generateFeed(name: name)

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.modelData = dummy
                self.isLoading = false
                success()
            }
        }
    }
}

func generateFeed(name: String) -> [DummyFeed] {
    var feeds: [DummyFeed] = []
    let user = DummyUser(withUsername: name, bio: "Full Stack Developer", profilePicture: UIImage(named: "Gellert")!)
    for index in 1...10 {
        let feed = DummyFeed(withUser: user, feedText: "\(index) this is some awesome text, but is super long to test the wrapping and auto resizing of my UITableView", feedImages: [UIImage(named: "sample1")!, UIImage(named:"sample2")!, UIImage(named:"sample3")!, UIImage(named:"sample4")!, UIImage(named:"sample5")!])
        feeds.append(feed)
    }
    
    return feeds
}
