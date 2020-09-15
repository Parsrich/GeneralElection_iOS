//
//  UIViewExtension.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/07.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    
//    @IBInspectable
//    var shadow: CGFloat {
//        get {
//            return layer.shadowRadius
//        }
//        set {
//            layer.shadowColor = UIColor.black.cgColor
//            layer.shadowOffset = CGSize(width: 0, height: 1.0)
//            layer.shadowOpacity = 0.5
//            layer.shadowRadius = newValue
////            let rect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.maxX, height: bounds.maxY)
//            
//            layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
//            
////            layer.masksToBounds = false
////            layer.shadowColor = UIColor.black.cgColor
////            layer.shadowOpacity = 0.5
////            layer.shadowOffset = .zero //CGSize(width: -1, height: 1)
////            layer.shadowRadius = newValue
////
////            let rect = CGRect(x: bounds.minX, y: bounds.minY, width: bounds.maxX, height: bounds.maxY)
////            layer.shadowPath = UIBezierPath(rect: rect).cgPath
////            layer.shouldRasterize = true
//////            layer.rasterizationScale = UIScreen.main.scale
//        }
//    }
    
    func addSubViewWithFullAutoLayout(subview: UIView,
                                      leading: CGFloat? = 0,
                                      trailing: CGFloat? = 0,
                                      top: CGFloat? = 0,
                                      bottom: CGFloat? = 0) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: self.topAnchor, constant: top ?? 0).isActive = top != nil
        subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: bottom ?? 0).isActive = bottom != nil
        subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leading ?? 0).isActive = leading != nil
        subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailing ?? 0).isActive = trailing != nil
    }
    
    func endAfterView(to view: UIView) {
        self.alpha = 1.0
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0.0
        }, completion: { _ in
            view.alpha = 0.0
            UIView.animate(withDuration: 0.3) {
                view.alpha = 1.0
            }
        })
    }
    
    var appDelegate: AppDelegate? {
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func setBorder(width: CGFloat, color: UIColor, radius: CGFloat = 0) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.cornerRadius = radius
    }
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
    func makeShadow(shadowRadius: CGFloat) {

        // set the shadow of the view's layer
//        layer.backgroundColor = UIColor.black.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowOpacity = 0.2
        layer.shadowRadius = shadowRadius
        layer.masksToBounds = false
    }
}
