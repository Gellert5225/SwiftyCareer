//
//  Globals.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import Foundation
import UIKit

/*
 Main view of the app. DrawerMenu is a custom side menu which accepts swipe gesture
 */
func prepareDrawerMenu() -> DrawerMenu {
    let messageVC = MessageViewController()
    let menu = LeftMenuViewController()
    let rootVC = RootViewController()
    //let rootNavController = UINavigationController(rootViewController: rootVC)
    let messageNavController = UINavigationController(rootViewController: messageVC)
    let drawerMenu = DrawerMenu(center: rootVC, left: menu, right: messageNavController)
    drawerMenu.modalPresentationStyle = .fullScreen
    drawerMenu.style = SlideIn()
    drawerMenu.rightMenuWidth = UIScreen.main.bounds.width
    return drawerMenu
}

/*
 Override the Swift print() function to support Debug
 */
func print(_ item: @autoclosure () -> Any, separator: String = " ", terminator: String = "\n") {
    #if DEBUG
    Swift.print(item(), separator: separator, terminator: terminator)
    #endif
}

func setupPopupDialogUI() {
    let pv = PopupDialogDefaultView.appearance()
    pv.titleFont    = UIFont(name: "SFUIText-Medium", size: 16)!
    pv.titleColor   = .white
    pv.messageFont  = UIFont(name: "SFUIText-Medium", size: 14)!
    pv.messageColor = UIColor(white: 0.8, alpha: 1)

    // Customize the container view appearance
    let pcv = PopupDialogContainerView.appearance()
    pcv.backgroundColor = UIColor(red:0.23, green:0.23, blue:0.27, alpha:1.00)
    pcv.cornerRadius    = 2
    pcv.shadowEnabled   = true
    pcv.shadowColor     = .black
    pcv.shadowOpacity   = 0.6
    pcv.shadowRadius    = 20
    pcv.shadowOffset    = CGSize(width: 0, height: 8)

    // Customize overlay appearance
    let ov = PopupDialogOverlayView.appearance()
    ov.blurEnabled     = true
    ov.blurRadius      = 30
    ov.liveBlurEnabled = true
    ov.opacity         = 0.7
    ov.color           = .black

    // Customize default button appearance
    let db = DefaultButton.appearance()
    db.titleFont      = UIFont(name: "SFUIText-Medium", size: 14)!
    db.titleColor     = .white
    db.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
    db.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)

    // Customize cancel button appearance
    let cb = CancelButton.appearance()
    cb.titleFont      = UIFont(name: "SFUIText-Medium", size: 14)!
    cb.titleColor     = UIColor(white: 0.6, alpha: 1)
    cb.buttonColor    = UIColor(red:0.25, green:0.25, blue:0.29, alpha:1.00)
    cb.separatorColor = UIColor(red:0.20, green:0.20, blue:0.25, alpha:1.00)
}

func showStandardDialog(animated: Bool = true, title: String, message: String, defaultButton: String) -> PopupDialog {
    setupPopupDialogUI()
    let popup = PopupDialog(title: title,
                            message: message,
                            buttonAlignment: .horizontal,
                            transitionStyle: .zoomIn,
                            tapGestureDismissal: true,
                            panGestureDismissal: true,
                            hideStatusBar: true) {
        print("Completed")
    }

    let buttonOne = DefaultButton(title: defaultButton) {}

    popup.addButtons([buttonOne])
    
    return popup
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

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}
