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
            BACKGROUND_COLOR.edgesIgnoringSafeArea(.all)
           SearchNavigation(text: $searchString, tapped: tapped, search: search, cancel: cancel) {
                ZStack {
                    BACKGROUND_COLOR.edgesIgnoringSafeArea(.all)
                    
                    Text("Hello")
                }
                .navigationBarItems(
                    leading: CircleImage(image: Image("Gellert")),
                    trailing: Image("ChatRed")
                )
            }
        }
    }
}

struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView()
    }
}
