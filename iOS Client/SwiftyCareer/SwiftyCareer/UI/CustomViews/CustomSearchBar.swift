//
//  CustomSearchBar.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 11/23/20.
//

import UIKit

class SearchBarContainerView: UIView {

    let searchBar: UISearchBar

    init(customSearchBar: UISearchBar, placeholderText: String) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.heightAnchor.constraint(equalToConstant: 30).isActive = true
        let backgroundImage = getImageWithCustomColor(color: UIColor.clear, size: CGSize(width: 265, height: 30))

        searchBar.setSearchFieldBackgroundImage(backgroundImage, for: .normal)
        searchBar.placeholder = placeholderText
        
        addSubview(searchBar)
    }

    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar(), placeholderText: "Search")
        self.frame = frame
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getImageWithCustomColor(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        for subView in searchBar.subviews {
            for subsubView in subView.subviews {
                for subsubsubView in subsubView.subviews {
                    if let textField = subsubsubView as? UITextField {
                        textField.borderStyle = UITextField.BorderStyle.roundedRect
                        textField.layer.cornerRadius = 15
                        textField.clipsToBounds = true
                        textField.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                        textField.font = UIFont(name: "SFUIText-Regular", size: 15)
                    }
                }
            }
        }
        searchBar.frame = bounds
        searchBar.layoutSubviews()
        searchBar.layoutIfNeeded()
    }
}
