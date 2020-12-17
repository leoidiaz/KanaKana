//
//  UITabBar+Extension.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/16/20.
//

import UIKit.UITabBar

extension UITabBarItem {
    static func makeTabBarItem(imageName: String, selected: String) -> UITabBarItem? {
        return UITabBarItem(title: nil,
                            image: UIImage(systemName: imageName)?.withTintColor(.gris, renderingMode: .alwaysOriginal),
                            selectedImage:  UIImage(systemName: selected)?.withTintColor(.gris, renderingMode: .alwaysOriginal))
    }
}
