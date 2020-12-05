//
//  HiraganaCollectionViewCell.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class HiraganaCollectionViewCell: UICollectionViewCell {
    //MARK: - Views
    lazy var kanaText = UILabel()
    
    //MARK: - Properties
    var hiragana: Hiragana? {
        didSet{
            setupCell()
        }
    }
    
    override var isHighlighted: Bool {
        didSet{
            if isHighlighted {bounce(duration: 0.5, delay: 0, damping: 1, velocity: 0.5, completion: nil)}
        }
    }
    //MARK: - Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else { return }
        layer.borderColor = UIColor.placeholderText.cgColor
    }
    
    private func setupCell(){
        guard let hira = hiragana else { return }
        addSubview(kanaText)
        kanaText.font = UIFont.systemFont(ofSize: 25)
        kanaText.text = hira.kana
        kanaText.textColor = .label
        backgroundColor = .systemBackground
        layer.borderWidth = 2
        layer.borderColor = UIColor.placeholderText.cgColor
        layer.cornerRadius = 10
        layout()
    }
    
    private func layout(){
        kanaText.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            kanaText.centerXAnchor.constraint(equalTo: centerXAnchor),
            kanaText.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
