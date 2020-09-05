//
//  LeftMenuView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct LeftMenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person")
                    .foregroundColor(.light_gray)
                    .imageScale(.large)
                Text("Profile")
                    .foregroundColor(.light_gray)
                    .font(.headline)
            }
            .padding(.top, 100)
            HStack {
                Image(systemName: "envelope")
                    .foregroundColor(.light_gray)
                    .imageScale(.large)
                Text("Messages")
                    .foregroundColor(.light_gray)
                    .font(.headline)
            }
                .padding(.top, 30)
            HStack {
                Image(systemName: "gear")
                    .foregroundColor(.light_gray)
                    .imageScale(.large)
                Text("Settings")
                    .foregroundColor(.light_gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 62.0/255, green: 67.0/255, blue: 83.0/255))
        //.background(Color(red: 32.0/255, green: 37.0/255, blue: 43.0/255))
        .edgesIgnoringSafeArea(.all)
    }
}


struct LeftMenuView_Previews: PreviewProvider {
    static var previews: some View {
        LeftMenuView()
    }
}
