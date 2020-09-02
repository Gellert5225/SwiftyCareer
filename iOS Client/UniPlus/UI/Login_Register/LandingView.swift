//
//  LandingView.swift
//  UniPlus
//
//  Created by Gellert Li on 8/31/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    @State var showingLogin = false
    @State var showingRegister = false
    
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    BACKGROUND_COLOR.edgesIgnoringSafeArea(.all)
                    VStack {
                        Image("LandingIcon")
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.width * 0.5)
                        
                            .padding(.bottom, 100)
                        
                        Text("Ask Anything")
                            .font(.title).bold()
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                        Button(action: {
                            withAnimation {
                                self.showingRegister.toggle()
                            }
                        }){
                            Text("Create Account")
                            .padding()
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: 40)
                        .foregroundColor(.white)
                        .background(TINT_COLOR)
                        .cornerRadius(40)
                        .font(.headline)
                        
                        Spacer()
                        
                        Group {
                            Button(action: { self.showingLogin.toggle() }){
                                Text("Login")
                                    .padding()
                            }
                        }
                    }
                }
            }
            
            ZStack {
                if showingRegister {
                    RegisterView(showing: $showingRegister)
                }
            }
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
