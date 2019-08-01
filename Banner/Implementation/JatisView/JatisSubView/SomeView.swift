//
//  SomeView.swift
//  Banner
//
//  Created by Guntur Budi on 24/04/19.
//  Copyright © 2019 Jati Piranti Solusindo. All rights reserved.
//

import UIKit


class SomeView: UICollectionViewCell {

    @IBOutlet var bgView: UIView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblSubtitle: UILabel!
    
    
    override func awakeFromNib() {
        DispatchQueue.main.async {
            self.bgView.addRoundShadow(fillColor: .black, cornerRadius: 20,
                                       shadowColor: .blue, shadowOpacity: 0.8,
                                       shadowOffSet: CGSize(width: 2, height: 1),
                                       shadowRadius: 5, scale: 1)
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
