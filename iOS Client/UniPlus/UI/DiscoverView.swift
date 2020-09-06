//
//  DiscoverView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/2/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI


struct DiscoverView: View {
    @State var searchString = ""
    @State var toggleNavBarItems = true
    
    func search() {
    }
    
    func tapped () {

    }
    
    func cancel() {

    }
    
    var body: some View {
        ZStack {
            Color.background_color.edgesIgnoringSafeArea(.all)
            SearchNavigation(text: $searchString, tapped: tapped, search: search, cancel: cancel) {
                ZStack {
                    Color.background_color.edgesIgnoringSafeArea(.all)
                    
                    Text("Hello")
                }
                .navigationBarItems(
                    leading: CircleImage(image: Image("Gellert"), width: 30, height:30),
                    trailing: Image("ChatRed")
                )
                    .edgesIgnoringSafeArea(.top)
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
