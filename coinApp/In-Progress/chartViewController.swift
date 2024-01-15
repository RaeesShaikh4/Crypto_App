//
//  chartViewController.swift
//  coinApp
//
//  Created by Vishal on 14/01/24.
//

import UIKit

class chartViewController: UIViewController {
    
    @IBOutlet var exchangeBtnView:UIView!
    @IBOutlet var btnViewCollection:[UIView]!
    @IBOutlet var cellDataView:UIView!
    @IBOutlet var transactionView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for btnView in btnViewCollection {
            btnView.layer.borderWidth = 1.0
            btnView.layer.cornerRadius = 10.0
            btnView.layer.borderColor = UIColor.black.cgColor
        }
        
        applyShadow(view: cellDataView)
        applyShadow(view: transactionView)
    }
    
    func applyShadow(view: UIView) {
        let cornerRadius: CGFloat = 8
        
        view.layer.cornerRadius = cornerRadius
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: cornerRadius))
        shadowPath.addLine(to: CGPoint(x: view.bounds.width, y: cornerRadius))
        shadowPath.addLine(to: CGPoint(x: view.bounds.width, y: view.bounds.height - cornerRadius))
        shadowPath.addArc(withCenter: CGPoint(x: view.bounds.width - cornerRadius, y: view.bounds.height - cornerRadius),
                          radius: cornerRadius,
                          startAngle: 0,
                          endAngle: CGFloat(Double.pi / 2),
                          clockwise: true)
        shadowPath.addLine(to: CGPoint(x: cornerRadius, y: view.bounds.height))
        shadowPath.addArc(withCenter: CGPoint(x: cornerRadius, y: view.bounds.height - cornerRadius),
                          radius: cornerRadius,
                          startAngle: CGFloat(Double.pi / 2),
                          endAngle: CGFloat.pi,
                          clockwise: true)
        shadowPath.addLine(to: CGPoint(x: 0, y: cornerRadius))
        
        view.layer.shadowPath = shadowPath.cgPath
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    
    
}
