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
    
    func addSubViewWithFullAutoLayout(subview: UIView,
                                      leading: CGFloat = 0,
                                      trailing: CGFloat = 0,
                                      top: CGFloat = 0,
                                      bottom: CGFloat = 0) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        subview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        subview.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        subview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
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
}
