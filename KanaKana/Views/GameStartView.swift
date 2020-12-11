//
//  GameStartView.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class GameStartView: UIView {
    //MARK: - SubViews
    lazy var highscoreLabel = UILabel()
    lazy var scoreLabel = UILabel()
    lazy var startButton = UIButton.makeButton(text: "Start", color: .label)
    lazy var difficultyControl = UISegmentedControl(items: Modes.items())
    lazy var difficultyDescription = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension GameStartView {
    private func setUpView(){
        highscoreLabel.font = UIFont.systemFont(
            ofSize: UIFont.preferredFont(forTextStyle: .largeTitle).pointSize,
            weight: .regular)
        highscoreLabel.adjustsFontForContentSizeCategory = true
        highscoreLabel.text = "Highscore:"
        scoreLabel.font = UIFont.systemFont(ofSize: 100)
        difficultyDescription.font = UIFont.systemFont(ofSize: 20)
        difficultyDescription.textColor = .placeholderText
        difficultyDescription.numberOfLines = 0
        difficultyDescription.textAlignment = .center
        difficultyControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.systemBackground], for: .selected)
        difficultyControl.selectedSegmentTintColor = .gris
        difficultyControl.selectedSegmentIndex = 0
        startButton.layer.borderWidth = 2
        startButton.layer.borderColor = UIColor.gris.cgColor
        startButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
        startButton.layer.cornerRadius = 10
        addSubview(difficultyControl)
        addSubview(highscoreLabel)
        addSubview(scoreLabel)
        addSubview(difficultyDescription)
        addSubview(startButton)
    }
    private func setLayout(){
        difficultyControl.translatesAutoresizingMaskIntoConstraints = false
        highscoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        startButton.translatesAutoresizingMaskIntoConstraints = false
        difficultyDescription.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([            
            highscoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            highscoreLabel.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 5.0),
            
            scoreLabel.topAnchor.constraint(equalToSystemSpacingBelow: highscoreLabel.bottomAnchor, multiplier: 7.0),
            scoreLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            startButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -100),
            startButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            difficultyControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            difficultyControl.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 25),
            
            difficultyDescription.topAnchor.constraint(equalToSystemSpacingBelow: difficultyControl.bottomAnchor, multiplier: 5.0),
            difficultyDescription.centerXAnchor.constraint(equalTo: centerXAnchor),
            difficultyDescription.widthAnchor.constraint(equalToConstant: frame.width - 100)
        ])
    }
}
