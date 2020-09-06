//
//  MainNavigationView.swift
//  UniPlus
//
//  Created by Gellert Li on 9/4/20.
//  Copyright © 2020 UniPlus. All rights reserved.
//

import SwiftUI
import UIKit

struct MainNavigationView<Content: View>: UIViewControllerRepresentable {
    
    var title: String
    var content: () -> Content
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: context.coordinator.rootViewController)
        //navigationController.navigationBar.delegate = context.coordinator as! UINavigationBarDelegate
        navigationController.navigationBar.prefersLargeTitles = false
        
        return navigationController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        context.coordinator.update(content: content())
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(content: content(), title: title)
    }
    
    class Coordinator: NSObject {
        let rootViewController: UIHostingController<Content>
        
        init(content: Content, title: String) {
            rootViewController = UIHostingController(rootView: content)
            
            rootViewController.navigationItem.title = title
            
            var image = UIImage(named: "Gellert")?.roundedImageWithBorder(width: 1, color: UIColor.light_gray)
            image = image?.withRenderingMode(.alwaysOriginal)
            rootViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style:.plain, target: nil, action: nil)
        }
        
        func position(for bar: UIBarPositioning) -> UIBarPosition { return .topAttached }
        
        func update(content: Content) {
            rootViewController.rootView = content
            rootViewController.view.setNeedsDisplay()
        }
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

