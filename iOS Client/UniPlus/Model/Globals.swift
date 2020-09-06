//
//  Globals.swift
//  UniPlus
//
//  Created by Gellert Li on 8/31/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import Foundation
import SwiftUI

extension UIColor {
    static let tint_color = UIColor(red: 53.0/255, green: 111/255, blue: 177/255, alpha: 1.0)
    static let background_color = UIColor(red: 42.0/255, green: 47.0/255, blue: 63.0/255, alpha: 1.0)
    static let light_gray = UIColor(red: 145.0/255, green: 154.0/255, blue: 172.0/255, alpha: 1.0)
    static let tableview_background = UIColor(red: 32/255, green: 37/255, blue: 53/255, alpha: 1)
}

extension Color {
    static let white = Color.white
    static let dark = Color(red: 42.0/255, green: 47.0/255, blue: 63.0/255)
    static let light_gray = Color(red: 145.0/255, green: 154.0/255, blue: 172.0/255)
    static let tint_color = Color(red: 53.0/255, green: 111/255, blue: 177/255)
    static let background_color = Color(red: 42.0/255, green: 47.0/255, blue: 63.0/255)

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

extension UIImage {
    class func colorForNavBar(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        //    Or if you need a thinner border :
        //    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context!.setFillColor(color.cgColor)
        context!.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            self.configure(nc)
        }
    }

}

class HostingController<ContentView>: UIHostingController<ContentView> where ContentView : View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
