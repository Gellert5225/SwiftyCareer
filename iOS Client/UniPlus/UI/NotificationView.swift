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
                
                List {
                    ForEach(0..<10) { _ in
                        HStack {
                            Text("Hello")
                        }
                    }
                }
                .onAppear() {
                    UITableView.appearance().backgroundColor = .clear
                    UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("Notification", displayMode: .inline)
            .navigationBarItems(
                leading: CircleImage(image: Image("Gellert"), width: 30, height:30),
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
