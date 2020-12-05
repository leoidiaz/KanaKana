//
//  AnswersView.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class AnswersView: UIView {
    //MARK: - View init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Properties
    lazy var letterButtons = [UIButton]()
    lazy var stackView1 = UIStackView.makeStackView(alignment: .center, distribution: .fillEqually, spacing: 15, axis: .horizontal)
    lazy var stackView2 = UIStackView.makeStackView(alignment: .center, distribution: .fillEqually, spacing: 15, axis: .horizontal)
}
    //MARK: - Methods
extension AnswersView {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        guard previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle else { return }
        letterButtons.forEach({$0.layer.borderColor = UIColor.gris.cgColor})
    }
    
    private func setupView(){
        for _ in 0...3 {
            let button = UIButton()
            button.setTitleColor(.label, for: .normal)
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 0)
            button.layer.borderColor = UIColor.gris.cgColor
            letterButtons.append(button)
        }
        addSubview(stackView1)
        addSubview(stackView2)
        stackView1.addArrangedSubview(letterButtons[0])
        stackView1.addArrangedSubview(letterButtons[1])
        stackView2.addArrangedSubview(letterButtons[2])
        stackView2.addArrangedSubview(letterButtons[3])
    }
    
    private func setLayout(){
        stackView1.translatesAutoresizingMaskIntoConstraints = false
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView1.topAnchor.constraint(equalTo: topAnchor),
            stackView1.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView1.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView1.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView2.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView2.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView2.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20),
            stackView2.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
