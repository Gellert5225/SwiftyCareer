//
//  ConnectionsView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/2/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct ConnectionsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.dark
                    .edgesIgnoringSafeArea(.all)
                
                Text("Hello")
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("Connections", displayMode: .inline)
            .navigationBarItems(
                leading: CircleImage(image: Image("Gellert")),
                trailing: Image("ChatRed")
            )
        }
    }
}

struct ConnectionsView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionsView()
    }
}
