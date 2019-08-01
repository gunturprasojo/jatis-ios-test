//
//  ViewController.swift
//  Banner
//
//  Created by Guntur Budi on 13/04/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit


class LoadBannerViewController: UIViewController {

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
    
    
    @IBOutlet var bannerView: UIView!
    
    @IBOutlet var secondBanner:JatisBanner!
    
    @IBOutlet var thirdBanner: UIView!
    
    @IBOutlet var fourthView: UIView! //30:25
    
    @IBOutlet var fifthView: UIView! //21:9
    
    @IBOutlet var sixthView: UIView! // 4:3
    
    @IBOutlet var seventhView: UIView! // 4:3
    
    @IBOutlet var eightView: UIView! // 4:3
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bannerPertama()
//        self.bannerKedua()
//        self.bannerKetiga()
//        self.bannerEmpat()
//        self.bannerLima()
//        self.bannerEnam()
//        self.bannerTujuh()
//        self.bannerDelapan()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    
    
    
    
    func bannerPertama(){
//        let banner = JatisBanner(_id: _id, images: images, enablePaging: true,
//                            imageContentMode: .scaleToFill, isImageTapped : true, scrollDirection: .horizontal,
//                            size: bannerView.bounds.size,cornerRadius: 10, aspectRatio: 9/16,
//                            animate: true,animationInterval: 1)
        let banner = JatisBanner()
        banner.images = images
        banner._id = _id
        banner.aspectRatio = 9/16
        banner.animate = true
        banner.cornerRadius = 20
        banner.size = bannerView.bounds.size
        banner.delegate = self
        banner.animationInterval = 3.0
        banner.reloadBanner()
        bannerView.addSubview(banner)
        bannerView.addRoundShadow(fillColor: .white, cornerRadius: 20, shadowColor: .gray, shadowOpacity: 0.9, shadowOffSet: CGSize(width: 5, height: 5), shadowRadius: 5, scale: 1.5)
      
    }
    
    
//
//
//    func bannerKedua(){
//        let banner2 = JatisBanner(_id: _id,images: images, enablePaging: false,
//                             imageContentMode: .scaleAspectFit, isImageTapped: false, scrollDirection: .vertical,
//                             size: secondBanner.bounds.size,cornerRadius: 30, aspectRatio: 1,
//                             animate: true, animationInterval: 2)
//        banner2.delegate = self
//        self.secondBanner.addSubview(banner2)
//    }
//
//
//
//    func bannerKetiga(){
//        let banner3 = JatisBanner(_id: _id, images: images, enablePaging: true, imageContentMode: .scaleAspectFill,
//                             isImageTapped: true, scrollDirection: .horizontal, size: thirdBanner.frame.size,
//                             cornerRadius: 15, aspectRatio: 9/16, animate: true, animationInterval: 3)
//        self.thirdBanner.addSubview(banner3)
//    }
//
//
//
//    //=====================
//
//    func bannerEmpat(){
//        let banner = JatisBanner(_id: _id, images: images, enablePaging: true, imageContentMode: .scaleAspectFit,
//                                  isImageTapped: true, scrollDirection: .vertical, size: fourthView.frame.size,
//                                  cornerRadius: 15, aspectRatio: 30/25, animate: true, animationInterval: 3)
//        self.fourthView.addSubview(banner)
//    }
//
//    func bannerLima(){
//        let banner = JatisBanner(_id: _id, images: images, enablePaging: true, imageContentMode: .scaleAspectFill,
//                                 isImageTapped: true, scrollDirection: .horizontal, size: fifthView.frame.size,
//                                 cornerRadius: 15, aspectRatio: 9/21, animate: true, animationInterval: 2)
//        self.fifthView.addSubview(banner)
//    }
//
//    func bannerEnam(){
//        let banner = JatisBanner(_id: _id, images: images, enablePaging: true, imageContentMode: .scaleAspectFill,
//                                 isImageTapped: true, scrollDirection: .horizontal, size: sixthView.frame.size,
//                                 cornerRadius: 5, aspectRatio: 3/4, animate: true, animationInterval: 1)
//        self.sixthView.addSubview(banner)
//    }
//
//    func bannerTujuh(){
//        let banner = JatisBanner(_id: _id, images: images, enablePaging: true, imageContentMode: .scaleAspectFill,
//                                 isImageTapped: true, scrollDirection: .vertical, size: seventhView.frame.size,
//                                 cornerRadius: 5, aspectRatio: 3/4, animate: true, animationInterval: 2)
//        self.seventhView.addSubview(banner)
//    }
//
//    func bannerDelapan(){
//        let banner = JatisBanner(_id: _id, images: images, enablePaging: true, imageContentMode: .scaleAspectFill,
//                                 isImageTapped: true, scrollDirection: .horizontal, size: eightView.frame.size,
//                                 cornerRadius: 5, aspectRatio: 3/4, animate: true, animationInterval: 3)
//        self.eightView.addSubview(banner)
//    }
//
//
    
    
}


extension LoadBannerViewController: JatisBannerProtocol{

    func didSelectBanner(_ data: String) {
        print("banner selected : \(data)")
    }
    
}

