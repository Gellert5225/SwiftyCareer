//
//  FirstView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/2/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.dark
                    .edgesIgnoringSafeArea(.all)
                Text("Hello")
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("Feed", displayMode: .inline)
            .navigationBarItems(
                leading: CircleImage(image: Image("Gellert")),
                trailing: Image("ChatRed")
            )
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
