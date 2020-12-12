//
//  UIButton+Extension.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/9/20.
//

import UIKit

extension UIButton{
    static func makeButton(text: String, color: UIColor, fontSize: CGFloat = UIFont.labelFontSize) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: fontSize)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }
}
