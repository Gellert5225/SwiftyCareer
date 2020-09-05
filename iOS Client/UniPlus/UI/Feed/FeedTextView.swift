//
//  FeedTextView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedTextView: View {
    @State var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .trailing, spacing: 10) {
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit a")
                .lineLimit(isExpanded ? nil : 3)
                .font(.custom("SF UI Text Regular", size: 15))
                .foregroundColor(.white)
            if (!isExpanded) {
                Button(action: {
                    print("tapped!")
                    self.isExpanded.toggle()
                    print(self.isExpanded)
                }, label: {
                    Text("More")
                    .font(.caption).bold()
                }).onTapGesture {
                    
                }.buttonStyle(BorderlessButtonStyle())
            }
            
        }
    }
}

struct FeedTextView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTextView(isExpanded: false)
    }
}
