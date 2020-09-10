//
//  FeedTextView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedTextView: View {
    var feed: Feed
    
    @State private var expanded: Bool = false

    @State private var truncated: Bool = false

    init(_ feed: Feed) {
        self.feed = feed
    }

    private func determineTruncation(_ geometry: GeometryProxy) {
        let total = self.feed.text.boundingRect(
            with: CGSize(
                width: geometry.size.width,
                height: .greatestFiniteMagnitude
            ),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: 16)],
            context: nil
        )

        if total.size.height > geometry.size.height {
            self.truncated = true
        }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(self.feed.text)
                .font(.custom("SF UI Text Regular", size: 15))
                .lineLimit(self.expanded ? nil : 3)
                .foregroundColor(.white)
                .background(GeometryReader { geometry in
                    Color.clear.onAppear {
                        self.determineTruncation(geometry)
                    }
                })

            if self.truncated {
                self.toggleButton
            }
        }
    }

    var toggleButton: some View {
        Button(action: { self.expanded.toggle() }) {
            Text(self.expanded ? "Show less" : "Show more")
                .font(.caption)
        }.buttonStyle(BorderlessButtonStyle())
    }
}

struct FeedTextView_Previews: PreviewProvider {
    static var previews: some View {
        FeedTextView(Feed(userName: "", bio: "", text: ""))
    }
}
