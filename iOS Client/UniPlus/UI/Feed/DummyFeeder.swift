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
    var id = UUID()
    
    var userName: String
    var bio: String
    var text: String
}

class FeedModel: ObservableObject {
    @Published var modelData: [Feed] = []
    
    func addElement(_ name: String, onSuccess success: @escaping () -> Void) {
        var dummy: [Feed] = []
        DispatchQueue.global(qos: .background).async {
            dummy = generateFeed(name)

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.modelData = dummy
                success()
            }
        }
    }
}

func generateFeed(_ name: String) -> [Feed] {
    var feedArray: [Feed] = [Feed]()
    
    for index in 1...10 {
        feedArray.append(Feed(userName: name, bio: "Undergrad student at UCR", text: "\(index) Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."))
    }
    
    return feedArray
}
