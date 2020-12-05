//
//  HighScoreView.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit
//import Lottie

class HighScoreView: UIView {
    
    lazy var highScoreText = UILabel()
    lazy var highScoreNumber = UILabel()
    lazy var dismissButton = UIButton.makeButton(text: "Dismiss", color: .placeholderText, fontSize: 20)
    lazy var container = UIView()
    var conffettiView: AnimationView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissView)))
        dismissButton.addTarget(self, action: #selector(dismissView), for: .touchDown)
        self.frame = UIScreen.main.bounds
        animateIn()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func dismissView(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut) { [weak self] in
            self?.container.transform = CGAffineTransform(translationX: 0, y: self?.frame.height ?? 0)
            self?.backgroundColor = .none
        } completion: { [weak self] (success) in
            if success {
                self?.subviews.forEach{ $0.removeFromSuperview() }
                self?.conffettiView = nil
                self?.removeFromSuperview()
            }
        }
    }
    
    @objc func animateIn(){
        container.transform = CGAffineTransform(translationX: 0, y: frame.height)
        alpha = 0
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn) { [weak self] in
            self?.container.transform = .identity
            self?.alpha = 1
        }
    }
    
    
    private func setupView(){
        backgroundColor = .placeholderText
        container.layer.borderWidth = 5
        container.layer.borderColor = UIColor.placeholderText.cgColor
        container.layer.cornerRadius = 20
        container.backgroundColor = .systemBackground
        conffettiView = AnimationView(name: "confetti")
        conffettiView?.contentMode = .scaleAspectFit
        conffettiView?.play(completion: { [weak self] (_) in
            self?.conffettiView?.play()
        })
        highScoreText.font = UIFont.systemFont(ofSize: 20)
        highScoreText.text = "New Highscore!"
        highScoreNumber.numberOfLines = 0
        highScoreNumber.font = UIFont.systemFont(ofSize: 50)
        addSubview(container)
        container.addSubview(conffettiView!)
        container.addSubview(highScoreText)
        container.addSubview(dismissButton)
        container.addSubview(highScoreNumber)
    }
    
    private func setLayout(){
        container.translatesAutoresizingMaskIntoConstraints = false
        conffettiView?.translatesAutoresizingMaskIntoConstraints = false
        highScoreText.translatesAutoresizingMaskIntoConstraints = false
        highScoreNumber.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.centerYAnchor.constraint(equalTo: centerYAnchor),
            container.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            container.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.25),
            
            conffettiView!.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            conffettiView!.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            conffettiView!.topAnchor.constraint(equalTo: container.topAnchor),
            conffettiView!.bottomAnchor.constraint(equalTo: container.bottomAnchor),

            highScoreText.topAnchor.constraint(equalTo: container.topAnchor, constant: 20),
            highScoreText.centerXAnchor.constraint(equalTo: container.centerXAnchor),

            highScoreNumber.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            highScoreNumber.centerYAnchor.constraint(equalTo: container.centerYAnchor),

            dismissButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -20),
            dismissButton.centerXAnchor.constraint(equalTo: container.centerXAnchor)
        ])
    }
}
