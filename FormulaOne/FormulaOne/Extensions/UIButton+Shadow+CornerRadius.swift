//
//  UIButton+Shadow+CornerRadius.swift
//  FormulaOne
//
//  Created by Anton Pogorelov on 23.04.2021.
//

import UIKit

extension UIButton {
    func addShadow(color: UIColor, radius: CGFloat, offset: CGSize, opacity: Float) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }
    func addCornerRadius(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
    }
}
