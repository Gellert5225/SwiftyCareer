//
//  SCNavigationBar.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 11/24/20.
//

import UIKit

protocol SCNavigationBarButtonDelegate {
    func barButtonTappedOn(_ side: DrawerMenu.Side)
}

class SCNavigationBarButton: UIBarButtonItem {
    
    var delegate: SCNavigationBarButtonDelegate?
    
    @objc func presentMenu(_ sender: SCNavigationBarButton) {
        delegate?.barButtonTappedOn(sender.side!)
    }
    
    var side: DrawerMenu.Side?
    
    init(on side: DrawerMenu.Side) {
        super.init()
        
        self.side = side
        
        var profileImage = UIImage(named: "Gellert")?.roundedImageWithBorder(width: 1, color: .light_gray)
        profileImage = profileImage?.withRenderingMode(.alwaysOriginal)
        
        var chatImage = UIImage(named: "ChatRed")
        chatImage = chatImage?.withRenderingMode(.alwaysOriginal)
        
        self.style = .plain
        self.target = self
        self.image = (side == .left ? profileImage : chatImage)
        self.action = #selector(presentMenu(_:))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
