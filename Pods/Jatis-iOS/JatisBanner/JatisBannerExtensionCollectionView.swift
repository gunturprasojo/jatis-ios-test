//
//  JatisBannerExtensionCollectionView.swift
//  Jatis-iOS
//
//  Created by Guntur Budi on 26/04/19.
//


import UIKit


extension UICollectionView{
    
    func animateCollectionView(coll:UICollectionView, isAnimate: Bool, animationInterval: Double, maxSection: Int, scrollDirection: ScrollDirection, size: CGSize)
    {
        var tmr = Timer()
        if (isAnimate){
            switch scrollDirection {
            case .horizontal:
                tmr = Timer.scheduledTimer(timeInterval: animationInterval, target: self, selector: #selector(horizontalAnimation), userInfo: nil, repeats: true)
                break
            case .vertical:
                tmr = Timer.scheduledTimer(timeInterval: animationInterval, target: self, selector: #selector(verticalAnimation), userInfo: nil, repeats: true)
                break
            @unknown default:
                fatalError()
            }
            tmr.fire()
        }
    }
    
    @objc func horizontalAnimation() {
        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.indexPathForItem(at: visiblePoint)
        
        if(numberOfSections>1){
            if(visibleIndexPath!.section < numberOfSections-1){
                let indexAnimation = NSIndexPath(row: 0, section:visibleIndexPath!.section+1)
                self .scrollToItem(at:indexAnimation as IndexPath, at:.right  , animated: true)
            }else {
                let indexAnimation = NSIndexPath(row: 0, section:0)
                self .scrollToItem(at:indexAnimation as IndexPath, at:.left  , animated: true)
            }
        }
    }
    
    @objc func verticalAnimation() {
        let visibleRect = CGRect(origin: self.contentOffset, size: self.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = self.indexPathForItem(at: visiblePoint)
        
        if(numberOfSections>1){
            if(visibleIndexPath!.section < numberOfSections-1){
                let indexAnimation = NSIndexPath(row: 0, section:visibleIndexPath!.section+1)
                self .scrollToItem(at:indexAnimation as IndexPath, at:.bottom  , animated: true)
            }else {
                let indexAnimation = NSIndexPath(row: 0, section:0)
                self .scrollToItem(at:indexAnimation as IndexPath, at:.top  , animated: true)
            }
        }
    }
    
}
