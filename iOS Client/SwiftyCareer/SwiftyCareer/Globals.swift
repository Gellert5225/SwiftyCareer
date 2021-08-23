//
//  Globals.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/15/20.
//

import Foundation
import UIKit
import SCWebAPI

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



func showStandardDialog(animated: Bool = true, title: String, message: String, defaultButton: String, defaultButtonAction: @escaping () -> Void) -> PopupDialog {
    setupPopupDialogUI()
    let popup = PopupDialog(title: title,
                            message: message,
                            buttonAlignment: .horizontal,
                            transitionStyle: .zoomIn,
                            tapGestureDismissal: true,
                            panGestureDismissal: true,
                            hideStatusBar: true
    ) {
        defaultButtonAction()
    }

    let buttonOne = DefaultButton(title: defaultButton) { defaultButtonAction() }

    popup.addButtons([buttonOne])
    
    return popup
}

func jsonToString(json: JSON) -> String? {
    do {
        let data1 = try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
        let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
        return convertedString
    } catch let myJSONError {
        print(myJSONError)
    }
    
    return ""
}

func stringToJSON(string: String) -> JSON? {
    let data = string.data(using: .utf8)!
    do {
        let jsonArray = try JSONSerialization.jsonObject(with: data, options : .allowFragments) as! JSON
        return jsonArray
    } catch let error as NSError {
        print(error)
    }
    return [:]
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

extension UINavigationBar {

    func setBottomBorderColor(color: UIColor, height: CGFloat) {
        let bottomBorderRect = CGRect(x: 0, y: frame.height, width: frame.width, height: height)
        let bottomBorderView = UIView(frame: bottomBorderRect)
        bottomBorderView.backgroundColor = color
        addSubview(bottomBorderView)
    }
}


extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                 return "iPod touch (5th generation)"
            case "iPod7,1":                                 return "iPod touch (6th generation)"
            case "iPod9,1":                                 return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
            case "iPhone4,1":                               return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
            case "iPhone7,2":                               return "iPhone 6"
            case "iPhone7,1":                               return "iPhone 6 Plus"
            case "iPhone8,1":                               return "iPhone 6s"
            case "iPhone8,2":                               return "iPhone 6s Plus"
            case "iPhone8,4":                               return "iPhone SE"
            case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                return "iPhone X"
            case "iPhone11,2":                              return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
            case "iPhone11,8":                              return "iPhone XR"
            case "iPhone12,1":                              return "iPhone 11"
            case "iPhone12,3":                              return "iPhone 11 Pro"
            case "iPhone12,5":                              return "iPhone 11 Pro Max"
            case "iPhone12,8":                              return "iPhone SE (2nd generation)"
            case "iPhone13,1":                              return "iPhone 12 mini"
            case "iPhone13,2":                              return "iPhone 12"
            case "iPhone13,3":                              return "iPhone 12 Pro"
            case "iPhone13,4":                              return "iPhone 12 Pro Max"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                    return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                      return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                    return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                    return "iPad (8th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
            case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                    return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                    return "iPad Air (4th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                      return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                    return "iPad mini (5th generation)"
            case "iPad6,3", "iPad6,4":                      return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                     return "iPad Pro (11-inch) (2nd generation)"
            case "iPad6,7", "iPad6,8":                      return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                    return "iPad Pro (12.9-inch) (4th generation)"
            case "AppleTV5,3":                              return "Apple TV"
            case "AppleTV6,2":                              return "Apple TV 4K"
            case "AudioAccessory1,1":                       return "HomePod"
            case "AudioAccessory5,1":                       return "HomePod mini"
            case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                        return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}
