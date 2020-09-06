//
//  RootView.swift
//  UniPlus
//
//  Created by Gellert Li on 8/31/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @State private var selection = 0
    @State var showCompose = false
    @State var showMenu = false
    
    private var actionSelection: Binding<Int> {
        Binding<Int>(get: {
            self.selection
        }) { (newValue: Int) in
            if newValue == 2 {
              self.showCompose = true
            } else {
                self.selection = newValue
            }
        }
    }
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        //UINavigationBar.appearance().backgroundColor = UIColor(red: 42.0/255, green: 47.0/255, blue: 63.0/255, alpha: 1.0)
        UINavigationBar.appearance().barTintColor = UIColor.background_color
        UINavigationBar.appearance().standardAppearance.shadowColor = .white
        UINavigationBar.appearance().isTranslucent = false
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            TabView(selection: actionSelection) {
                FeedView(show: $showMenu)
                    .tabItem {
                        VStack {
                            if (selection == 0) {
                                Image("HomeSelected")
                            } else {
                                Image("Home")
                            }
                        }
                    }
                    .tag(0)
                DiscoverView()
                    .tabItem {
                        VStack {
                            if (selection == 1) {
                                Image("SearchSelected")
                            } else {
                                Image("Search")
                            }
                        }
                    }
                    .tag(1)
                Text("Dummy View")
                    .tabItem {
                        VStack {
                            Image("Write")
                        }
                    }
                    .tag(2)
                ConnectionsView()
                    .tabItem {
                        VStack {
                           if (selection == 3) {
                               Image("FriendsSelected")
                           } else {
                               Image("Friends")
                           }
                        }
                    }
                    .tag(3)
               NotificationView()
                    .tabItem {
                        VStack {
                           if (selection == 4) {
                               Image("AlertSelected")
                           } else {
                               Image("Alert")
                           }
                        }
                    }
                    .tag(4)
            }
                
            .sheet(isPresented: self.$showCompose) {
                Text("Compose View")
            }
            .offset(x: self.showMenu ? UIScreen.main.bounds.width * 0.7 : 0)
            
            if self.showMenu {
                LeftMenuView()
                    .frame(width: UIScreen.main.bounds.width * 0.7)
                    .transition(.move(edge: .leading))
            }
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

