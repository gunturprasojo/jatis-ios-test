//
//  JatisShadow.swift
//  Jatis-iOS
//
//  Created by Guntur Budi on 26/04/19.
//


/*
 The code below is used to create a banner type display.
 The functions below include:
   1.  Make UIView type class with image display to display the desired banner.
 2.  Create a collectionview type display to display the image you want to display in the JatisBanner class.
 3.  Protocol to get the value of the id from the banner that has been clicked.
 */


import UIKit


//  Protocol to receive an action.
//  This Protocol used to receive an action that if user press the image,
//  then return a string that contains id of the image based on index of String (array types).
public protocol JatisBannerProtocol: class {
    func didSelectBanner(_ data: String , tagBanner: Int)
}


//  Declaration of class JatisBanner
open class JatisBanner:UIView{
    
    //  Create an array type of UIImages -> Image that want to show.
    open var images: [UIImage] = []
    
    //  Create an array of String -> Id of an image.
    open var _id: [String] = []
    
    //  Create an array of String -> Id of an image.
    open var size: CGSize = CGSize(width: 0, height: 0)
    
    //  Create a float type variable to set corner radius,
    //  that used to set the radius of the corner of a view.
    open var cornerRadius: CGFloat = 0.0
    
    //  Create a float type variable to set aspect ratio of Image that wanted to show.
    open var aspectRatio:CGFloat = 0.0
    
    //  Create a content mode type variable to set the image content fill type
    open var imageContentMode:ContentMode = .scaleToFill
    
    //  Create a bool type that if want to give an action (click/press) to an image that shown
    open var isImageTapped:Bool = false
    
    //  Create a bool type that set to animate the Banner
    open var animate:Bool = true
    
    //  Set an interval (seconds) of animation each image duration want to be shown
    open var animationInterval:Double = 0.0
    
    //  Set a paging configuration for displaying the images
    open var enablePaging:Bool = true
    
    //  Set a scroll Direction between horizontal (left to right by default) or vertical (up to bottom . by default)
    open var scrollDirection:UICollectionView.ScrollDirection = .horizontal
    
    // Declare a delegate to receiver an action of collectionView
    public weak var delegate: JatisBannerProtocol?
    
    open func reloadBanner(){
        self.frame =  CGRect(x: 0, y: 0, width: size.width, height: size.height)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.cornerRadius
        self.formatCollectionBannerView()
    }
    
}


extension JatisBanner{
    
    private func formatCollectionBannerView(){
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize =  CGSize(width: self.size.width, height:self.size.width*(aspectRatio))
        flowLayout.scrollDirection = scrollDirection
        let collectionView = UICollectionView(frame:self.frame, collectionViewLayout: flowLayout)
        // collectionView.frame = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height*(aspectRatio))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "jatisBannerCellIdentifier")
        collectionView.isPagingEnabled = enablePaging
        collectionView.isScrollEnabled = true
        collectionView.layer.masksToBounds = true
        if (animate){
            collectionView.animateCollectionView(coll:collectionView, isAnimate: animate,
                                                 animationInterval: animationInterval,
                                                 maxSection: images.count,
                                                 scrollDirection: scrollDirection,
                                                 size : CGSize(width: self.bounds.size.width, height:self.bounds.size.width*(aspectRatio)))
        }
        self.addSubview(collectionView)
        collectionView.reloadData()
    }
    
}



extension JatisBanner: UICollectionViewDelegate, UICollectionViewDataSource{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return images.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "jatisBannerCellIdentifier", for: indexPath)
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height:  self.bounds.size.width*(self.aspectRatio))
        imageView.image = self.images[indexPath.section]
        imageView.contentMode = self.imageContentMode
        cell.addSubview(imageView)
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (isImageTapped){
            delegate?.didSelectBanner(_id[indexPath.section], tagBanner: collectionView.tag)
        }
    }
    
    
    
}
