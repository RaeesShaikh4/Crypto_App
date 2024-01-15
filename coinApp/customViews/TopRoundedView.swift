//
//  TopRoundedCorners.swift
//  coinApp
//
//  Created by Vishal on 09/01/24.
//

import UIKit

class TopRoundedView: UIView {

    var cornerRadius: CGFloat = 30.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        // Do not call setTopRoundedCorners here
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setTopRoundedCorners()
    }

    func setTopRoundedCorners() {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
        )

        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
}
