//
//  JatisShadow.swift
//  Jatis-iOS
//
//  Created by Guntur Budi on 26/04/19.
//


import UIKit

extension UIView {
    
    func addDefaultShadow(offset:CGSize,shadowRadius:CGFloat=1,opacity:Float=0.5) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: offset.width, height: offset.height)
        layer.shadowRadius = shadowRadius
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = 1
    }
    
    func addCustomShadow(shadowColor: UIColor,
                         shadowOpacity: Float = 0.5,
                         shadowOffSet: CGSize,
                         shadowRadius: CGFloat = 1,
                         scale: CGFloat = 1)
    {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffSet
        layer.shadowRadius = shadowRadius
        
        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale
    }
    
    func addRoundShadow(
        fillColor: UIColor,
        cornerRadius: CGFloat = 15,
        shadowColor: UIColor=UIColor.black,
        shadowOpacity: Float = 0.5,
        shadowOffSet: CGSize = CGSize(width: 1, height: 1),
        shadowRadius: CGFloat = 1, scale: CGFloat = 1)
    {
        var shadowLayer: CAShapeLayer!
        self.layoutSubviews()
        self.backgroundColor = .clear
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: shadowOffSet.width, height: shadowOffSet.height)
            shadowLayer.shadowOpacity = shadowOpacity
            shadowLayer.shadowRadius = shadowRadius
            shadowLayer.fillColor = fillColor.cgColor
            layer.insertSublayer(shadowLayer, at: 0)
            
        }
        
    }
    
}
