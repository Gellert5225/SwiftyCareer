//
//  RegisterTextField.swift
//  UniPlus
//
//  Created by Gellert Li on 9/1/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI

struct TextFieldTyped: UIViewRepresentable {
    let keyboardType: UIKeyboardType
    let returnVal: UIReturnKeyType
    let tag: Int
    let secure: Bool
    @Binding var selectedField: Int
    @Binding var text: String
    var placeholder: String
    var onCommit: (() -> Void)?
    
    @State var finishedEditing = false

    func makeUIView(context: Context) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.keyboardType = self.keyboardType
        textField.returnKeyType = self.returnVal
        textField.tag = self.tag
        textField.isSecureTextEntry = secure
        textField.delegate = context.coordinator
        textField.autocorrectionType = .no
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.light_gray]
        )
        textField.textColor = .white

        return textField
    }

    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<TextFieldTyped>) {
        uiView.text = text
        context.coordinator.newSelection = { newSelection in
            DispatchQueue.main.async {
                self.selectedField = newSelection
            }
        }

        if uiView.tag == self.selectedField && !finishedEditing {
            uiView.becomeFirstResponder()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UITextFieldDelegate {
        var parent: TextFieldTyped
        var newSelection: (Int) -> () = { _ in }

        init(_ textField: TextFieldTyped) {
            self.parent = textField
        }

        func textFieldDidChangeSelection(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent.text = textField.text ?? ""
            }
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            self.newSelection(textField.tag)
        }

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            if textField.returnKeyType == .go {
                textField.resignFirstResponder()
                parent.finishedEditing = true
                parent.onCommit?()
            } else {
                self.newSelection(textField.tag + 1)
            }
            return true
        }

    }
}
