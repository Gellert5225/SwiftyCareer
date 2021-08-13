//
//  FeedViewModel.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/17/20.
//

import Foundation
import SCWebAPI

class FeedViewModel: SCViewModel {
    
    override func fetch(onCompletion complete: @escaping ([SCObject]?, Error?) -> Void) {
        let feeds = SCResource(path: "/feeds")
        
        SCXHR().request(resource: feeds) {response in
            if let error = response.err {
                self.isLoading = false
                complete(nil, error)
            } else if let feeds = response.res {
                self.objects = []
                if let feedsJSON = feeds["info"] as? [JSON] {
                    for feedJSON in feedsJSON {
                        let feed = Feed(from: feedJSON)
                        self.objects.append(feed)
                    }
                }
                self.isLoading = false
                complete(self.objects, nil)
            }
        }
    }
}
