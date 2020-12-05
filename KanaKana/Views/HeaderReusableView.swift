//
//  HeaderReusableView.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class HeaderReusableView: UICollectionReusableView {
    static var reuseIdentifier: String { return String(describing: HeaderReusableView.self) }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(
            ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize,
            weight: .medium)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.setContentCompressionResistancePriority(
            .defaultHigh,
            for: .horizontal)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        addSubview(titleLabel)
        layout()
    }
    
    private func layout(){
        if UIDevice.current.userInterfaceIdiom == .pad {
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -5)
            ])
        } else {
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
                titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor)
            ])
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

