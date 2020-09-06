//
//  DummyFeeder.swift
//  UniPlus
//
//  Created by Gellert Li on 9/5/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import Foundation
import SwiftUI

struct Feed: Identifiable {
    var id: Int
    
    var userName: String
    var bio: String
    var text: String
}

func generateFeed() -> [Feed] {
    var feedArray: [Feed] = [Feed]()
    
    for index in 1...10 {
        feedArray.append(Feed(id: index, userName: "Jiahe Gellert Li", bio: "Undergra student at UCR", text: "\(index) Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
    }
    
    return feedArray
}

class MyModel: ObservableObject {
    @Published var loading: Bool = false {
        didSet {
            if oldValue == false && loading == true {
                self.load()
            }
        }
    }
    
    @Published var feeds: [Feed] = generateFeed()
    
    func load() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.feeds = generateFeed()
            self.loading = false
        }
    }
}
