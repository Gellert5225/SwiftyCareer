//
//  RegisterView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/1/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI
import Parse

struct RegisterView: View {
    @Binding var showing: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var selectedField = 0
    @State var fields: [String] = ["", "", "", ""]
    @State var showRoot = false
    
    var bottomPadding: CGFloat = 20
    var placeholders: [String] = ["Username", "Email", "Password", "Confirm Password"]
    
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
                
                Text("Create Your Account")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding(.bottom, bottomPadding)
                
                VStack {
                    ForEach(0..<4) { index in
                        TextFieldTyped(
                            keyboardType: .default,
                            returnVal: index == 3 ? .go : .next,
                            tag: index,
                            secure: index > 1,
                            selectedField: self.$selectedField,
                            text: self.$fields[index],
                            placeholder: self.placeholders[index],
                            onCommit: {
                                self.signUp()
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
    
    func signUp() {
        let user = PFUser()
        user.username = self.fields[0]
        user.password = self.fields[2]
        user.email = self.fields[1]

        user.signUpInBackground {
          (succeeded: Bool, error: Error?) -> Void in
          if let error = error {
            let errorString = error.localizedDescription
            print("Error: \(errorString)")
          } else {
           withAnimation{
                self.showRoot.toggle()
                //self.presentationMode.wrappedValue.dismiss()
            }
          }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView(showing: .constant(true))
    }
}
