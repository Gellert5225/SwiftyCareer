//
//  ComposeAccessoryView.swift
//  ComposeAccessoryView
//
//  Created by Gellert Li on 8/23/21.
//

import UIKit

protocol ComposeAccessoryViewDelegate {
    func bold()
    
    func italic()
    
    func orderedList()
    
    func bulletList()
}

class ComposeAccessoryView: UIView {
    
    var delegate: ComposeAccessoryViewDelegate?
        
    @IBOutlet weak var boldView: UIImageView!
    @IBOutlet weak var italicView: UIImageView!
    @IBOutlet weak var underlineView: UIImageView!
    @IBOutlet weak var ordredView: UIImageView!
    @IBOutlet weak var bulletView: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    class func instanceFromNib() -> ComposeAccessoryView {
        return UINib(nibName: "ComposeAccessoryView", bundle: .main).instantiate(withOwner: nil, options: nil)[0] as! ComposeAccessoryView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("awake")
        
        boldView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bold)))
    }
    
    @objc func bold() {
        delegate?.bold()
    }

}
