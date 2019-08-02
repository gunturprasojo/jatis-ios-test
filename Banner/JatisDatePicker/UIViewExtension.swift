//
//  UIViewExtension.swift
//  Jatis-iOS
//
//  Created by Tirta Rivaldi on 01/08/19.
//

import Foundation
import UIKit

extension UIView {
    typealias action = (Bool)->Void
    func animShow(){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
        
    }
    func animHide(_ completion: @escaping action){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
            completion(true)
        })
    }
}

