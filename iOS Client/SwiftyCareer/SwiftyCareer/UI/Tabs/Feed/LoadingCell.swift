//
//  LoadingCell.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/16/20.
//

import UIKit

class LoadingCell: UITableViewCell {

    @IBOutlet weak var activitiIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.separatorInset = UIEdgeInsets(top: 0, left: CGFloat.greatestFiniteMagnitude, bottom: 0, right: 0);
        activitiIndicator.color = .light_gray
        activitiIndicator.startAnimating()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
