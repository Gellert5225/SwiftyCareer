//
//  CarouView.swift
//  ETCarouSwift
//
//  Created by Elena Slovushch on 31/01/2020.
//  Copyright © 2020 ElenaSlovushch. All rights reserved.
//

import UIKit
import Parse

@objc public protocol CarouViewDelegate:NSObjectProtocol{
    
    @objc optional func carouViewDidChangeImage(_ carouView:CarouView, index currentImageIndex:Int)
    @objc optional func carouView(_ carouView:CarouView, didTapImageAt index:Int)
}

let CAROUCELL = "caroucell"

public class CarouView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public weak var delegate: CarouViewDelegate?
    
    open var images: [UIImage]!
    open var imageDatas: [PFFileObject]!
    
    private var pageControl: CarouPageControl!
    private var collectionView: CarouCollectionView!
    
    private var currentImageIndex: Int!
    private var timeInterval: Double = 2
    
    open var width: CGFloat!
    private var autoScrollEnabled = false
    private var scrollDirection: CarouDirection = .rightToLeft
    
    public var dotColor: UIColor {
        get {
            return self.pageControl.pageIndicatorTintColor ?? UIColor.white
        }
        set {
            if self.pageControl != nil {
                self.pageControl.pageIndicatorTintColor = newValue
            }
        }
    }
    
    public var currentDotColor: UIColor {
        get {
            return self.pageControl.currentPageIndicatorTintColor ?? UIColor.black
        }
        set {
            if self.pageControl != nil {
                self.pageControl.currentPageIndicatorTintColor = newValue
            }
        }
    }
    
    public var carouIndex: Int {
        get {
            return self.currentImageIndex
        }
    }
    
    public var dotSize: CarouDotSize {
        get{
            return self.pageControl.dotSize
        }
        set{
            if self.pageControl != nil {
                self.pageControl.setDotSize(newValue)
            }
        }
    }
    
    public func set(imageDataSet: [PFFileObject], rideDirection:CarouDirection = .rightToLeft) {
        self.imageDatas = imageDataSet
        self.width = self.frame.width
        
        guard self.imageDatas.count > 0 else {
            
            let image = UIImage(color: UIColor.systemBlue, size: self.frame.size)
            let imageView = UIImageView(image: image)
            imageView.frame = self.bounds
            self.addSubview(imageView)
            return
        }
        
        guard self.imageDatas.count > 1 else {
            let imageView = PFImageView()//UIImageView(image: self.images[0])
            imageView.frame = self.bounds
            imageView.file = self.imageDatas[0]
            imageView.contentMode = .scaleAspectFill
            imageView.layer.masksToBounds = true
            self.addSubview(imageView)
            imageView.loadInBackground()
            return
        }
        
        self.scrollDirection = rideDirection
        
        if self.scrollDirection == .rightToLeft{
            
            self.currentImageIndex = 0
            
        }else{
            
            self.imageDatas = self.imageDatas.reversed()
            
            self.currentImageIndex = self.images.count
            
        }

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: self.frame.width, height: self.frame.height)
        
        
        self.collectionView = CarouCollectionView(frame: self.bounds, collectionViewLayout: layout, imagesCount: self.imageDatas!.count, contentOffsetX:0)
        self.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let pageControlFrame = CGRect(x: self.width/2-self.width*0.375, y: frame.height*0.8, width: self.width*0.75, height:frame.height*0.25)
        self.pageControl = CarouPageControl(frame: pageControlFrame, imagesCount: self.imageDatas.count, currentPage: self.currentImageIndex)
//        self.pageControl.addTarget(self, action: #selector(self.pageControlTapped(sender:)), for: .touchDown)
//        self.pageControl.addTarget(self, action: #selector(self.pageControlUntapped(sender:)), for: .touchUpInside)
        self.addSubview(self.pageControl)
        
    }
    
    public init(frame: CGRect, imageDataSet: [PFFileObject], rideDirection:CarouDirection = .rightToLeft) {
        super.init(frame: frame)
        
        
        set(imageDataSet: imageDataSet)
    }
     
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.75)
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageDatas.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CAROUCELL, for: indexPath)
        let imageView = PFImageView()
        imageView.file = self.imageDatas[indexPath.row]
        imageView.frame = CGRect(origin: CGPoint.zero, size: cell.frame.size)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        cell.addSubview(imageView)
        imageView.loadInBackground()
        cell.backgroundColor = UIColor.purple
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        guard delegate.responds(to: #selector(self.delegate?.carouView(_:didTapImageAt:))) else { return }
        delegate.carouView?(self, didTapImageAt: self.currentImageIndex)
    }
    
    public func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        //self.timer.invalidate()
    }
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let contentOffset = CGPoint(x:scrollView.contentOffset.x, y:0)
        let width = scrollView.frame.size.width//scrollView.bounds.size.width
        let index = Int(contentOffset.x/width)
        self.pageControl.currentPage = index
        self.currentImageIndex = index
        
        
        guard let delegate = self.delegate else { return }
        guard delegate.responds(to: #selector(self.delegate?.carouViewDidChangeImage(_:index:))) else { return }
        delegate.carouViewDidChangeImage!(self, index: self.currentImageIndex)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        guard let delegate = self.delegate else { return }
        guard delegate.responds(to: #selector(self.delegate?.carouViewDidChangeImage(_:index:))) else { return }
        delegate.carouViewDidChangeImage!(self, index: self.currentImageIndex)
    }
    
    @objc private func pageControlTapped(sender:UIPageControl){
        //self.timer.invalidate()
    }
    
    @objc private func pageControlUntapped(sender:UIPageControl){
        //print("CURRENT PAGE \(sender.currentPage)")
        self.currentImageIndex = sender.currentPage+1
        let offsetX = CGFloat(sender.currentPage+1)*self.frame.size.width
        self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)

    }
    
    @objc private func timedOut(sender:Timer){
        
        var nextPage:Int!
        
        if self.scrollDirection == .rightToLeft{
            
            nextPage = self.currentImageIndex
            
            if currentImageIndex == 0{
                self.collectionView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
                nextPage = 0
                
            }
            if currentImageIndex == self.images.count-1{
                self.collectionView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
                self.currentImageIndex = 1
                nextPage = 1
            }
            
            if currentImageIndex < self.images.count-1 {
                self.currentImageIndex += 1
                let offsetX = CGFloat(self.currentImageIndex)*self.frame.width
                self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
                if self.currentImageIndex == self.images.count-1{
                    nextPage = 0
                }
            }
            
        }else{
            
            nextPage = self.currentImageIndex - 2
            
            if currentImageIndex == self.images.count-1{
                nextPage = self.images.count-3
                let offsetX = CGFloat(self.images.count-1)*self.frame.width
                self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
            }
            
            if self.currentImageIndex == 0{
                self.currentImageIndex = self.images.count-2
                nextPage = self.currentImageIndex - 2
                let offsetX = CGFloat(self.images.count-2)*self.frame.width
                self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
            }
            
            if currentImageIndex > 0 {
                self.currentImageIndex -= 1
                let offsetX = CGFloat(self.currentImageIndex)*self.frame.width
                self.collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
                if self.currentImageIndex == 0{
                    nextPage = self.images.count-3
                }
            }
        }
        self.pageControl.currentPage = nextPage!
    }
    
    private func updateContentOffset(_ offsetX:CGFloat, forView:UICollectionView, completion:()->Void){
        forView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        completion()
    }
    
}


public enum CarouDirection{
    case leftToRight, rightToLeft
}


extension UIImage {
  
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}
