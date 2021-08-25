//
//  ComposeAccessoryView.swift
//  ComposeAccessoryView
//
//  Created by Gellert Li on 8/23/21.
//

import UIKit

protocol ComposeAccessoryViewDelegate {
    func orderedList()
    
    func bulletList()
    
    func format(_ format: String, sender: UIImageView)
}

class ComposeAccessoryView: UIView {
    
    var delegate: ComposeAccessoryViewDelegate?
        
    @IBOutlet weak var boldView: UIImageView!
    @IBOutlet weak var italicView: UIImageView!
    @IBOutlet weak var underlineView: UIImageView!
    @IBOutlet weak var ordredView: UIImageView!
    @IBOutlet weak var bulletView: UIImageView!
    
    class func instanceFromNib() -> ComposeAccessoryView {
        return UINib(nibName: "ComposeAccessoryView", bundle: .main).instantiate(withOwner: nil, options: nil)[0] as! ComposeAccessoryView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        boldView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(format(_:))))
        italicView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(format(_:))))
        underlineView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(format(_:))))
    }
    
    @objc func format(_ sender: UITapGestureRecognizer) {
        let imageView = sender.view as! UIImageView
        var format = ""
        
        switch imageView.tag {
        case 1:
            format = "Bold"
            break
        case 2:
            format = "Italic"
            break
        case 3:
            format = "Underline"
            break
        default:
            break
        }
        delegate?.format(format, sender: imageView)
    }

}
