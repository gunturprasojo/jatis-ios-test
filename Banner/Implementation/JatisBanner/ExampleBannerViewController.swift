//
//  ExampleBannerViewController.swift
//  Banner
//
//  Created by Guntur Budi on 24/04/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit


class ExampleBannerViewController: UIViewController,JatisBannerProtocol {
   
    

    let images:[UIImage] =  [
        UIImage(named: "pic-1")!,
        UIImage(named: "pic-2")!,
        UIImage(named: "pic-3")!,
    ]
    
    let _id:[String] =  [
        "Lake",
        "River",
        "Mountain",
    ]
    
    @IBOutlet var topBanner: UIView!
    @IBOutlet var textViewBanner: UITextView!
    @IBOutlet var bottomBanner: UIView!
    
    var obj = [someObj]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateObject()
        self.generateView()
    }
    
    func generateObject(){
        let tempObj = someObj()
        for (index, image) in images.enumerated(){
            tempObj.image = image
            tempObj._id = _id[index]
            obj.append(tempObj)
        }
    }
    
    func generateView(){
//        let banner = JatisBanner(_id: _id, images: images, enablePaging: true,
//                                 imageContentMode: .scaleToFill, isImageTapped : true, scrollDirection: .horizontal,
//                                 size: topBanner.bounds.size,cornerRadius: 10, aspectRatio: 2/3,
//                                 animate: true,animationInterval: 5)
//        banner.delegate = self
//        self.topBanner.addSubview(banner)
//        self.topBanner.addDefaultShadow(offset: CGSize(width: 2, height: 3),
//                                        shadowRadius:5)
    }
    
    
    
    func didSelectBanner(_ data: String) {
        print("data select \(data)")
    }
    
    class someObj {
        var image = UIImage()
        var _id = String()
    }

}
