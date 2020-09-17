//
//  FeedCell.swift
//  SwiftyCareer
//
//  Created by Gellert Li on 9/16/20.
//

import UIKit

class FeedCell: UITableViewCell {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var feedTextview: UITextView!
    @IBOutlet weak var imageScrollView: CarouView!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var commentView: UIView!
    @IBOutlet weak var shareView: UIView!
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var shareImage: UIImageView!
    
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var shareLabel: UILabel!
    
    var feed: Feed {
        didSet {
            setup()
        }
    }
    
    required init?(coder: NSCoder) {
        feed = generateFeed(name: "Gellert")[0]
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .background_color
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero
        
        setupGestures()
    }
    
    func setup() {
        profileImageView.image = feed.user.profilePicture
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.light_gray.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        usernameLabel.text = feed.user.username
        bioLabel.text = feed.user.bio
        feedTextview.text = feed.text
        imageScrollView.set(imageSet: feed.images)
        imageScrollView.autoRideEnabled = false
        imageScrollView.currentDotColor = .light_gray
        bioLabel.textColor = .light_gray
        
        likeImage.image = feed.likedByCurrentUser ? UIImage(named: "LikeSelected")! : UIImage(named: "Like")
        likeLabel.textColor = .light_gray
        commentLabel.textColor = .light_gray
        shareLabel.textColor = .light_gray
        
        feedTextview.sizeToFit()
        feedTextview.isScrollEnabled = false
    }
    
    func setupGestures() {
        let likeTap = UITapGestureRecognizer(target: self, action: #selector(self.handleLike(_:)))
        self.likeView.addGestureRecognizer(likeTap)
        
        let commentTap = UITapGestureRecognizer(target: self, action: #selector(self.handleComment(_:)))
        self.commentView.addGestureRecognizer(commentTap)
        
        let sharetTap = UITapGestureRecognizer(target: self, action: #selector(self.handleShare(_:)))
        self.shareView.addGestureRecognizer(sharetTap)
    }
    
    @objc func handleLike(_ sender: UITapGestureRecognizer? = nil) {
        if feed.likedByCurrentUser {
            feed.likedByCurrentUser = false
            likeImage.image = UIImage(named: "Like")
        } else {
            feed.likedByCurrentUser = true
            likeImage.image = UIImage(named: "LikeSelected")
        }
    }
    
    @objc func handleComment(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
    }
    
    @objc func handleShare(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
