//
//  DetailsView.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class DetailsView: UIView {
    //MARK: - Subviews
    lazy var kanaText = UILabel()
    lazy var romajiText = UILabel()
    lazy var typeText = UILabel()
    lazy var container = UIView()
    lazy var closeButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
        self.frame = UIScreen.main.bounds
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        animateView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView(){
        subviews.forEach{ $0.removeFromSuperview() }
        removeFromSuperview()
    }
    
    @objc func animateView(){
        container.transform = CGAffineTransform(translationX: 0, y: frame.height)
        alpha = 0.8
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseInOut) { [weak self] in
            self?.container.transform = .identity
            self?.alpha = 1
        }
    }
}
    //MARK: - Methods
extension DetailsView {
    func setupView(){
        backgroundColor = .placeholderText
        container.layer.cornerRadius = 20
        container.backgroundColor = .systemBackground
        closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .gris
        closeButton.addTarget(self, action: #selector(dismissView), for: .touchDown)
        kanaText.font = UIFont.systemFont(ofSize: 70)
        kanaText.textColor = .gris
        romajiText.font = UIFont.systemFont(ofSize: 40)
        romajiText.textColor = .gris
        typeText.font = UIFont.systemFont(ofSize: 25)
        typeText.textColor = .placeholderText
        addSubview(container)
        container.addSubview(kanaText)
        container.addSubview(romajiText)
        container.addSubview(typeText)
        container.addSubview(closeButton)
    }
    func setLayout(){
        container.translatesAutoresizingMaskIntoConstraints = false
        kanaText.translatesAutoresizingMaskIntoConstraints = false
        romajiText.translatesAutoresizingMaskIntoConstraints = false
        typeText.translatesAutoresizingMaskIntoConstraints = false
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            
            closeButton.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            closeButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 15),
            
            kanaText.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            kanaText.topAnchor.constraint(equalTo: container.topAnchor, constant: 30),
            
            romajiText.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            romajiText.topAnchor.constraint(equalTo: kanaText.bottomAnchor, constant: 25),
            
            typeText.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            typeText.topAnchor.constraint(equalTo: romajiText.bottomAnchor, constant: 25),
        ])
    }
}
