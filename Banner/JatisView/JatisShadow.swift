//
//  JatisShadow.swift
//  Jatis-iOS
//
//  Created by Guntur Budi on 26/04/19.
//

/*
 The code below is an addition to UIView.
 The functions below include:
 1. Default Shadow
 Gives a shadow to a view with default values.
 2. Custom Shadow
 Giving a shadow to a view that can be changed include: shadow color, shadow opacity (default value is
 0.5), shadow offset to adjust the location of the shadow, radius to adjust the blurisity of the shadow
 and the shadow scale.
 3. RoundShadow
 Gives a shadow to a view where the view has a round shape on the corner. These parameters include:
 color fill in the desired view, value from corner radius, shadow color, shadow opacity, shadow location,
 radius of shadow, and scale of the shadow you want to display in a View
 */

import UIKit

extension UIView {
    
    //  Function to add default shadow
    //  This function should be used for a display
    //  that does not use modifications at all (only shadows)
    public func addDefaultShadow(offset:CGSize,shadowRadius:CGFloat=1,opacity:Float=0.5) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: offset.width, height: offset.height)
        layer.shadowRadius = shadowRadius
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = 1
    }
    
    
    //  Function to add Custom Shadow
    //  This function should be used for a shadow that does not have round corners,
    //  only changes the base color, opacity, radius and scale in the desired shadow
    public func addCustomShadow(shadowColor: UIColor,
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
    
    
    //  Function to add roundShadow
    //  This function should be used for a shadow that has a complex level of modification,
    //  especially in a view that has a round corner. This function has input parameters to determine the
    //  color of a display,the radius value of a display, the color of the shadow,
    //  the opacity of the shadow, the location of the shadow,
    //  the radius of the shadow and the scale of the shadow
    public func addRoundShadow(
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

