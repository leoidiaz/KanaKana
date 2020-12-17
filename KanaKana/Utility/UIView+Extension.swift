//
//  UIView+Extension.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/16/20.
//

import UIKit.UIView

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
