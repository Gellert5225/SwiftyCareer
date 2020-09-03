//
//  NotificationView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/2/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.dark
                .edgesIgnoringSafeArea(.all)
                
                Text("Hello")
            }
            
            .navigationBarTitle("Notification", displayMode: .inline)
            .navigationBarItems(
                leading: CircleImage(image: Image("Gellert")),
                trailing: Image("ChatRed")
            )
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
