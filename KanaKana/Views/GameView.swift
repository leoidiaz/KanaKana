//
//  GameView.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class GameView: UIView {

    //MARK: - Subviews
    
    lazy var kanaLabel = UILabel()
    lazy var scoreLabel = UILabel()
    lazy var timeProgress = UIProgressView()
    lazy var restartButton = UIButton.makeButton(text: "Restart", color: .label)
    lazy var cancelButton = UIButton.makeButton(text: "Cancel", color: .label)
    lazy var answersView = AnswersView()
    lazy var buttonStack = UIStackView.makeStackView(alignment: .center, distribution: .fillEqually, spacing: 0, axis: .horizontal)
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func shuffleLetterButtons(){
        answersView.letterButtons.shuffle()
    }
    
    func userInteractionToggle(_ isOn: Bool){
        for button in answersView.letterButtons {
            button.isUserInteractionEnabled = isOn
        }
    }
}


extension GameView {
    private func setupView(){
        scoreLabel.font = UIFont.systemFont(ofSize: 30)
        kanaLabel.font = UIFont.systemFont(ofSize: 90)
        timeProgress.layer.cornerRadius = 10
        timeProgress.clipsToBounds = true
        timeProgress.tintColor = .gris
        addSubview(timeProgress)
        addSubview(kanaLabel)
        addSubview(scoreLabel)
        addSubview(answersView)
        addSubview(restartButton)
        addSubview(cancelButton)
        addSubview(buttonStack)
        buttonStack.addArrangedSubview(cancelButton)
        buttonStack.addArrangedSubview(restartButton)
    }
    
    private func setLayout(){
        timeProgress.translatesAutoresizingMaskIntoConstraints = false
        kanaLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        restartButton.translatesAutoresizingMaskIntoConstraints = false
        answersView.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeProgress.centerXAnchor.constraint(equalTo: centerXAnchor),
            timeProgress.heightAnchor.constraint(equalToConstant: 20),
            timeProgress.widthAnchor.constraint(equalToConstant: frame.width / 2),
            timeProgress.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            
            scoreLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -50),
            scoreLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            
            kanaLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            kanaLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80),
            
            answersView.widthAnchor.constraint(equalToConstant: frame.width / 2),
            answersView.centerXAnchor.constraint(equalTo: centerXAnchor),
            answersView.topAnchor.constraint(equalTo: kanaLabel.bottomAnchor, constant: 30),
            
            buttonStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            buttonStack.widthAnchor.constraint(equalToConstant: frame.width / 2),
            buttonStack.bottomAnchor.constraint(equalTo: answersView.bottomAnchor, constant: 125),
        ])
    }
}
