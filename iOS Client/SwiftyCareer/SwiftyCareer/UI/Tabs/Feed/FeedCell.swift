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
    
    @IBOutlet weak var aspectRatio: NSLayoutConstraint!
    var feed: Feed? {
        didSet {
            setup()
        }
    }
    
    required init?(coder: NSCoder) {
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
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: URL(string: "http://192.168.1.16:1336/api/files/" + self.feed!.author!.profile_picture)!)
            DispatchQueue.main.async {
                self.profileImageView.image = UIImage(data: data ?? Data())
            }
        }

        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.light_gray.cgColor
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        usernameLabel.text = feed?.author?.display_name
        bioLabel.text = feed?.author?.position
    
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "SFUIText-Regular", size: 15)!,
            .foregroundColor: UIColor.white,
        ]
        let attributedQuote = NSAttributedString(string: feed!.text!.htmlToString.trimmingCharacters(in: .whitespacesAndNewlines), attributes: attributes)
        feedTextview.attributedText = attributedQuote

        likeLabel.text = String(feed!.like_count!)
        commentLabel.text = String(feed!.comment_count!)
        shareLabel.text = String(feed!.share_count!)
        
        bioLabel.textColor = .light_gray
        likeImage.image = UIImage(named: "LikeSelected")!
        likeLabel.textColor = .light_gray
        commentLabel.textColor = .light_gray
        shareLabel.textColor = .light_gray
        
        feedTextview.sizeToFit()
        feedTextview.isScrollEnabled = false
        
        if feed!.images!.count > 0 {
            setUpImages()
        }
    }
    
    fileprivate func setUpImages() {
        imageScrollView.set(imageDataSet: feed!.images!)
        imageScrollView.currentDotColor = .white
        imageScrollView.dotColor = .light_gray
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
        var amount = 0
//        if feed.isLikedByCurrentUser! {
//            feed.isLikedByCurrentUser = false
//            likeImage.image = UIImage(named: "Like")
//            feed.numberOfLikes! -= 1
//            amount = -1
//        } else {
//            feed.isLikedByCurrentUser = true
//            likeImage.image = UIImage(named: "LikeSelected")
//            feed.numberOfLikes! += 1
//            amount = 1
//        }
//        likeLabel.text = String(feed.numberOfLikes!)
//        PFCloud.callFunction(inBackground: "IncrementLikes", withParameters: ["id": feed.objectId!, "amount": amount]) { (res, error) in
//            if let err = error {
//                print(err.localizedDescription)
//            }
//        }
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
