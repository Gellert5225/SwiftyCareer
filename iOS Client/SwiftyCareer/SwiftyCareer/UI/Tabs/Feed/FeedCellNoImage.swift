//
//  FeedCellNoImage.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 4/28/21.
//

import UIKit

class FeedCellNoImage: FeedCell {

    override var feed: Feed {
        didSet {
            setup()
        }
    }
    
}
