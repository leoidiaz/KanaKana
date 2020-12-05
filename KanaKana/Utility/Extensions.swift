//
//  Extensions.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

extension UIColor {
    static let gris = UIColor(named: "gris")!
}

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

extension UIStackView {
    static func makeStackView(alignment: UIStackView.Alignment, distribution: UIStackView.Distribution, spacing: CGFloat = 0, axis: NSLayoutConstraint.Axis) -> UIStackView {
        let stackView = UIStackView()
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        stackView.axis = axis
        return stackView
    }
}

extension Int {
    func asString() -> String {
        return String(self)
    }
}

extension UIView {
     func bounce(duration: TimeInterval, delay: TimeInterval, damping: CGFloat, velocity: CGFloat, completion: ((Bool) -> Void)?){
        transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: velocity,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.transform = CGAffineTransform.identity
                       },
                       completion: completion
        )
    }
}

extension UITabBarItem {
    static func makeTabBarItem(imageName: String, selected: String) -> UITabBarItem? {
        return UITabBarItem(title: nil,
                            image: UIImage(systemName: imageName)?.withTintColor(.gris, renderingMode: .alwaysOriginal),
                            selectedImage:  UIImage(systemName: selected)?.withTintColor(.gris, renderingMode: .alwaysOriginal))
    }
}
