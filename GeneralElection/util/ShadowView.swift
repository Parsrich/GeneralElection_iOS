//
//  ShadowView.swift
//  GeneralElection
//
//  Created by Minki on 2020/03/15.
//  Copyright © 2020 Parsrich. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
    
    @IBInspectable var startColor:   UIColor
        = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.3) {
        didSet {
            updateColors()
        }
    }
    @IBInspectable var endColor:     UIColor =
        UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.0) {
        didSet {
            updateColors()
        }
    }
    @IBInspectable var startLocation: Double =   0.05 { didSet { updateLocations() }}
    @IBInspectable var endLocation:   Double =   0.95 { didSet { updateLocations() }}

    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    func updatePoints() {
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
    
}

