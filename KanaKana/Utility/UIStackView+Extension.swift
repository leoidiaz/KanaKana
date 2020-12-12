//
//  UIStackView+Extension.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/9/20.
//

import UIKit

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
