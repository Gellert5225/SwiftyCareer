//
//  Globals.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import Foundation
import UIKit

func prepareDrawerMenu() -> DrawerMenu {
    let messageVC = MessageViewController()
    let menu = LeftMenuViewController()
    let rootVC = RootViewController()
    let rootNavController = UINavigationController(rootViewController: rootVC)
    let messageNavController = UINavigationController(rootViewController: messageVC)
    let drawerMenu = DrawerMenu(center: rootNavController, left: menu, right: messageNavController)
    drawerMenu.modalPresentationStyle = .fullScreen
    drawerMenu.style = SlideIn()
    drawerMenu.rightMenuWidth = UIScreen.main.bounds.width
    return drawerMenu
}

func print(_ item: @autoclosure () -> Any, separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    Swift.print(item(), separator: separator, terminator: terminator)
    #endif
}

extension UIColor {
    static let tint_color = UIColor(red: 53.0/255, green: 111/255, blue: 177/255, alpha: 1.0)
    static let background_color = UIColor(red: 42.0/255, green: 47.0/255, blue: 63.0/255, alpha: 1.0)
    static let light_gray = UIColor(red: 145.0/255, green: 154.0/255, blue: 172.0/255, alpha: 1.0)
    static let tableview_background = UIColor(red: 32/255, green: 37/255, blue: 53/255, alpha: 1)
    static let menu_background = UIColor(red: 62.0/255, green: 67.0/255, blue: 83.0/255, alpha: 1)
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIImage {
    class func colorForNavBar(color: UIColor) -> UIImage {
        //let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        //    Or if you need a thinner border :
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()

        context!.setFillColor(color.cgColor)
        context!.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }
}

extension UIImage {
    func roundedImageWithBorder(width: CGFloat, color: UIColor) -> UIImage? {
        let square = CGSize(width: min(size.width, size.height) + width * 2, height: min(size.width, size.height) + width * 2)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = .center
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = width
        imageView.layer.borderColor = color.cgColor
        UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        imageView.layer.render(in: context)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}
