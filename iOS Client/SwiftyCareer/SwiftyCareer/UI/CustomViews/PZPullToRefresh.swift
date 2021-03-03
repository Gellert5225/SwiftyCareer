//
//  PZPullToRefresh.swift
//  UniPlus
//
//  Created by Gellert Li on 9/5/20.
//  Copyright © 2020 UniPlus. All rights reserved.
// 

import UIKit

@objc public protocol PZPullToRefreshDelegate: AnyObject {

    func pullToRefreshDidTrigger(_ view: PZPullToRefreshView) -> ()
    @objc optional func pullToRefreshLastUpdated(_ view: PZPullToRefreshView) -> Date
}

public enum RefreshState {
    case normal
    case pulling
    case loading
}

open class PZPullToRefreshView: UIView {
    
    @objc open var statusTextColor: UIColor? {
        didSet {
            activityView?.color = statusTextColor
            statusLabel?.textColor = statusTextColor
        }
    }
    open var timeTextColor = UIColor(red: 53/255.0, green:111/255.0, blue:177/255.0, alpha: 1)
    
    @objc open var bgColor: UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }

    open var flipAnimatioDutation: CFTimeInterval = 0.18

    @objc open var thresholdValue: CGFloat = 40.0
    
    open var lastUpdatedKey = "RefreshLastUpdated"

    open var isShowUpdatedTime = true
    
    open var lastUpdatedLabel: UILabel?
    
    open var statusLabel: UILabel?

    open var arrowImage: CALayer?
 
    open var activityView: UIActivityIndicatorView?
    
    @objc open var arrow: UIImage? {
        didSet {
            arrowImage?.contents = arrow?.cgImage
        }
    }
    
    
    fileprivate var _isLoading = false
    
    @objc open var isLoading: Bool {
        get {
            return _isLoading
        }
        set {
            _isLoading = state == .loading
        }
    }
    
    open var _state: RefreshState = .normal
    open var state: RefreshState {
        get {
           return _state
        }
        set {
            switch newValue {
            case .normal:
                statusLabel?.text = "Pull down to refresh"
                activityView?.stopAnimating()
                refreshLastUpdatedDate()
                rotateArrowImage(0)
            case .pulling:
                statusLabel?.text = "Release to refresh"
                rotateArrowImage(CGFloat(Double.pi))
            case .loading:
                statusLabel?.text = "Loading..."
                activityView?.startAnimating()
                CATransaction.begin()
                CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
                arrowImage?.isHidden = true
                CATransaction.commit()
            }
            _state = newValue
        }
    }
    
    open var scrollView: UIScrollView?
   
    @objc open weak var delegate: PZPullToRefreshDelegate?
    open var lastUpdatedLabelCustomFormatter: ( (_ date:Date)->String )?
    
    fileprivate func rotateArrowImage(_ angle: CGFloat) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(flipAnimatioDutation)
        arrowImage?.transform = CATransform3DMakeRotation(angle, 0.0, 0.0, 1.0)
        CATransaction.commit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleWidth
        backgroundColor = bgColor

        let label = UILabel(frame: CGRect(x: 0, y: frame.size.height - 22.0, width: frame.size.width, height: 20.0))
        label.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        label.font = UIFont(name: "SFUIText-Light", size: 12)
        label.textColor = timeTextColor
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        lastUpdatedLabel = label
        if let time = UserDefaults.standard.object(forKey: lastUpdatedKey) as? String {
            lastUpdatedLabel?.text = time

        } else {
            lastUpdatedLabel?.text = nil
        }
        
        statusLabel = UILabel(frame: CGRect(x: 50, y: frame.size.height - 30.0, width: frame.size.width - 50, height: 20.0))
        statusLabel?.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        statusLabel?.font = UIFont(name: "SFUIText-Regular", size: 12)
        statusLabel?.textColor = statusTextColor
        statusLabel?.backgroundColor = UIColor.clear
        statusLabel?.textAlignment = .left
        addSubview(statusLabel!)
        
        arrowImage = CALayer()
        arrowImage?.frame = CGRect(x: 20, y: frame.size.height - 28.0, width: 15.0, height: 15.0)
        arrowImage?.contentsGravity = CALayerContentsGravity.resizeAspect
        arrowImage?.contents = (arrow ?? UIImage(named:"Arrow")!).cgImage
        layer.addSublayer(arrowImage!)
        
        activityView = UIActivityIndicatorView(style: .medium)
        activityView?.color = statusTextColor
        activityView?.frame = CGRect(x: 20, y: frame.size.height - 26.0, width: 15.0, height: 15.0)
        addSubview(activityView!)
        
        state = .normal
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc open func refreshLastUpdatedDate() {
        if isShowUpdatedTime {
            if let date = delegate?.pullToRefreshLastUpdated?(self) {
                var lastUpdateText:String
                if let customFormatter = self.lastUpdatedLabelCustomFormatter {
                    lastUpdateText = customFormatter(date)
                }else{
                    let formatter = DateFormatter()
                    formatter.amSymbol = "AM"
                    formatter.pmSymbol = "PM"
                    formatter.dateFormat = "MMM dd - HH:mm"
                    lastUpdateText = "Last Updated: \(formatter.string(from: date))"
                }
                lastUpdatedLabel?.text = lastUpdateText
                let userDefaults = UserDefaults.standard
                userDefaults.set(lastUpdatedLabel?.text, forKey: lastUpdatedKey)
                userDefaults.synchronize()
            }
        }
    }

    @objc open func refreshScrollViewDidScroll(_ scrollView: UIScrollView) {
        if state == .loading {
            UIView.animate(withDuration: 0.2, animations: {
                var offset = max(scrollView.contentOffset.y * -1, 0)
                offset = min(offset, self.thresholdValue)
                //scrollView.setContentOffset(CGPoint(x:0.0, y:-offset), animated: true)
                scrollView.contentInset = UIEdgeInsets(top: offset, left: 0.0, bottom: 0.0, right: 0.0)
            })
        } else if scrollView.isDragging {
            let loading = false
            if state == .pulling && scrollView.contentOffset.y > -thresholdValue && scrollView.contentOffset.y <= 0.0 && !loading {
                state = .normal

            } else if state == .normal && scrollView.contentOffset.y < -thresholdValue && !loading {
                state = .pulling
            }
        }
    }
    
    @objc open func refreshScrollViewDidEndDragging(_ scrollView: UIScrollView) {
        let loading = false
        if scrollView.contentOffset.y <= -thresholdValue && !loading {
            state = .loading
            delegate?.pullToRefreshDidTrigger(self)
        }
    }
    
    @objc open func refreshScrollViewDataSourceDidFinishedLoading(_ scrollView: UIScrollView, _ inset: UIEdgeInsets) {
        UIView.animate(withDuration: 0.3, animations: {
            scrollView.contentInset = inset
        })
        arrowImage?.isHidden = false
        state = .normal
    }
    
    @objc open func refreshScrollViewDataSourceDidFinishedLoading() {
        UIView.animate(withDuration: 0.3, animations: {
            self.scrollView!.contentInset = UIEdgeInsets.zero
        })
        arrowImage?.isHidden = false
        state = .normal
    }
    
    func beginRefresh (_ scrollView: UIScrollView){
        UIView.animate(withDuration: 0.2, animations: {
            var offset = max(scrollView.contentOffset.y * -1, 0)
            offset = min(offset, self.thresholdValue)
            scrollView.contentInset = UIEdgeInsets(top: self.thresholdValue, left: 0.0, bottom: 0.0, right: 0.0)
        })
    }
    
}
