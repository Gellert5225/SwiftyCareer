//
//  FirstView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/2/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct FeedView: View {
    @Binding var showMenu: Bool
    
    init(show: Binding<Bool>) {
//        UITableView.appearance().backgroundColor = .clear
//        UITableView.appearance().tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: Double.leastNonzeroMagnitude))
        self._showMenu = show
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                BACKGROUND_COLOR.edgesIgnoringSafeArea(.all)
                
                FeedList()
                    .listRowBackground(Color.clear)
                    .disabled(self.showMenu)
            }
            
            .edgesIgnoringSafeArea(.top)
            .navigationBarTitle("Feed", displayMode: .inline)
            .navigationBarItems(
                leading: CircleImage(image: Image("Gellert"), width: 30, height:30)
                    .gesture(
                        TapGesture()
                            .onEnded { _ in
                                withAnimation{
                                    self.showMenu.toggle()
                                }
                            }
                    ),
                trailing: Image("ChatRed")
            )
            
            .gesture(
                TapGesture()
                    .onEnded { _ in
                        withAnimation{
                            if (self.showMenu) {
                                self.showMenu = false
                            }
                        }
                    }
            )
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(show: .constant(false))
    }
}
