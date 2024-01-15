//
//  styles.swift
//  coinApp
//
//  Created by Vishal on 09/01/24.
//

import UIKit

class Styles {
    static let shared = Styles()
    
    func setBorderColor(hexColor: Int, for view: UIView) {
        let borderColor = UIColor(
            red: CGFloat((hexColor & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hexColor & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hexColor & 0x0000FF) / 255.0,
            alpha: 1.0
        )
        
        view.layer.borderColor = borderColor.cgColor
        view.layer.borderWidth = 1.0
    }
    
    func addTopRoundCorners(to view: UIView, radius: CGFloat) {
        let path = UIBezierPath(
            roundedRect: view.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
    }
}


