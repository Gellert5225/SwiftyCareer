//
//  LoginView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI
import Parse

struct LoginView: View {
    @Binding var showing: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedField = 0
    @State var fields: [String] = ["", ""]
    @State var showRoot = false
    
    var bottomPadding: CGFloat = 20
    var placeholders: [String] = ["Username", "Password"]
    
    var body: some View {
        ZStack {
            Color.background_color.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        UIApplication.shared.endEditing()
                        withAnimation {
                            self.showing.toggle()
                        }
                    }) {
                        Text("Cancel")
                            .foregroundColor(Color.light_gray)
                    }
                    .foregroundColor(.white)
                    
                    Spacer()
                }.padding()
                    .padding(.bottom, 10)
                
                Text("Login to UniPlus")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, bottomPadding)
                
                VStack {
                    ForEach(0..<2) { index in
                        TextFieldTyped(
                            keyboardType: .default,
                            returnVal: index == 1 ? .go : .next,
                            tag: index,
                            secure: index == 1,
                            selectedField: self.$selectedField,
                            text: self.$fields[index],
                            placeholder: self.placeholders[index],
                            onCommit: {
                                print(self.fields)
                                withAnimation{
                                    self.showRoot.toggle()
                                    //self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                        ).frame(height: 30)
                        Divider().background(Color.light_gray)
                            .padding(.bottom, self.bottomPadding)
                    }
                }
                .padding(EdgeInsets(top: 0, leading: 40, bottom: 0, trailing: 40))
                
                Spacer()
            }
            
            RootView()
               .offset(x: 0, y: self.showRoot ? 0 : UIScreen.main.bounds.height)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(showing: .constant(true))
    }
}
