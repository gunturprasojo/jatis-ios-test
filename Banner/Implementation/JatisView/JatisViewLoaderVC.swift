//
//  JatisViewLoaderViewController.swift
//  Banner
//
//  Created by Guntur Budi on 24/04/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit

class JatisViewLoaderViewController: UIViewController {

    
    @IBOutlet var redView: UIView!
    @IBOutlet var yellowView: UIView!
    @IBOutlet var greenView: UIView!
    @IBOutlet var cyanView: UIView!
    @IBOutlet var purpleView: UIView!
    
    @IBOutlet var btnTest: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.generateView()
    }

    func generateView(){
        
        btnTest.addRoundShadow(fillColor: .red,
                                 cornerRadius: 10,
                                 shadowColor: .black,
                                 shadowOpacity: 0.8,
                                 shadowOffSet: CGSize(width: -5, height: 2),
                                 shadowRadius: 5,
                                 scale: 1)
//        redView.addDefaultShadow(offset: CGSize(width: 5, height: 2))
        
       
       // redView.backgroundColor = UIColor.clear
        redView.addRoundShadow(fillColor: .red,
                            cornerRadius: 50,
                            shadowColor: .black,
                            shadowOpacity: 0.8,
                            shadowOffSet: CGSize(width: -5, height: 2),
                            shadowRadius: 5,
                            scale: 1)
        
        yellowView.addCustomShadow(shadowColor: UIColor.black,shadowOpacity: 0.2,
                                   shadowOffSet: CGSize(width: 8, height: 5),
                                   shadowRadius: 5)
        
        greenView.addCustomShadow(shadowColor: .black,
                                  shadowOpacity: 0.6,
                                  shadowOffSet: CGSize(width: -5, height: 5),
                                  shadowRadius: 15,
                                  scale: 5)
        
        cyanView.addRoundShadow(fillColor: .cyan,
                                cornerRadius: 50,
                                shadowColor: .black,
                                shadowOpacity: 0.5,
                                shadowOffSet: CGSize(width: 5, height: 2),
                                shadowRadius: 10,
                                scale: 1)
        
        purpleView.addCustomShadow(shadowColor: UIColor.black,
                                  shadowOpacity: 0.8,
                                  shadowOffSet: CGSize(width: 5, height: 2),
                                  shadowRadius: 5, scale: 5)
    }

}
