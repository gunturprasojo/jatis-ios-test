
import UIKit


protocol JatisBannerProtocol: class {
    func didSelectBanner(_ data: String)
}


class JatisBanner: UIView {
    
    var images: [UIImage]
    var _id: [String]
    var cornerRadius: CGFloat
    var aspectRatio:CGFloat
    var imageContentMode:ContentMode
    var isImageTapped:Bool
    var animate:Bool
    var animationInterval:Double
    var enablePaging:Bool
    var scrollDirection:UICollectionView.ScrollDirection
    
    
    weak var delegate: JatisBannerProtocol?
    
    init(_id:[String], images : [UIImage], enablePaging : Bool,
         imageContentMode : ContentMode, isImageTapped : Bool, scrollDirection: UICollectionView.ScrollDirection,
         size:CGSize, cornerRadius: CGFloat, aspectRatio: CGFloat,
         animate: Bool,animationInterval:Double)
    {
        self._id = _id
        self.images = images
        self.enablePaging = enablePaging
        
        self.cornerRadius = cornerRadius
        self.aspectRatio = aspectRatio
        
        self.imageContentMode = imageContentMode
        self.isImageTapped = isImageTapped
        self.scrollDirection = scrollDirection
        
        self.animate = animate
        self.animationInterval = animationInterval
        
        super.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height));
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.cornerRadius
        
        self.formatCollectionBannerView()
        return
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension JatisBanner{
    
    func formatCollectionBannerView(){
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.estimatedItemSize =  CGSize(width: self.bounds.size.width, height:self.bounds.size.width*(aspectRatio))
        flowLayout.scrollDirection = scrollDirection
        let collectionView = UICollectionView(frame:self.frame, collectionViewLayout: flowLayout)
        collectionView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.width*(aspectRatio))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cellIdentifier")
        collectionView.reloadData()
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
    }
    
}



extension JatisBanner: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIdentifier", for: indexPath)
        let imageView = UIImageView()
        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height:  self.bounds.size.width*(aspectRatio))
        imageView.image = images[indexPath.section]
        imageView.contentMode = self.imageContentMode
        cell.addSubview(imageView)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (isImageTapped){
            delegate?.didSelectBanner(_id[indexPath.section])
        }
    }
    
    
    
}
