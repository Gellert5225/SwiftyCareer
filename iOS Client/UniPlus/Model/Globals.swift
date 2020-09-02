//
//  Globals.swift
//  UniPlus
//
//  Created by Gellert Li on 8/31/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import Foundation
import SwiftUI

let TINT_COLOR = Color(red: 53.0/255, green: 111/255, blue: 177/255)
let BACKGROUND_COLOR = Color(red: 42.0/255, green: 47.0/255, blue: 63.0/255)
let LIGHT_GRAY = UIColor(red: 145.0/255, green: 154.0/255, blue: 172.0/255, alpha: 1.0)

extension Color {
    static let white = Color.white
    static let dark = Color(red: 42.0/255, green: 47.0/255, blue: 63.0/255)
    static let light_gray = Color(red: 145.0/255, green: 154.0/255, blue: 172.0/255)

    static func backgroundColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .light {
            return white
        } else {
            return dark
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
