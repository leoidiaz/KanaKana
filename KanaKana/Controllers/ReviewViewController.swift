//
//  ReviewViewController.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

protocol HighScoreDelegate: AnyObject {
    func updateLabel(mode: Modes)
}

class ReviewViewController: UIViewController {
    //MARK: - Properties
    lazy var gameStartView = GameStartView(frame: view.frame)
    var mode: Modes = .easy
    let persistenceManager = PersistenceManager.shared
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        layout()
    }
    //MARK: - Init Methods
    private func setupView(){
        updateDifficulty(difficulty: .easy)
        gameStartView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchDown)
        gameStartView.difficultyControl.addTarget(self, action: #selector(difficultyChanged(_:)), for: .valueChanged)
        view.addSubview(gameStartView)
    }
    private func updateDifficulty(difficulty: Modes){
        mode = difficulty
        switch difficulty {
        case .easy:
            if let highScore = persistenceManager.scores?.easy {
                gameStartView.scoreLabel.text = highScore.asString()
            }
            gameStartView.difficultyDescription.text = "Ideal for beginners! Contains only Gojūon Hiragana."
        case .medium:
            if let highScore = persistenceManager.scores?.medium {
                gameStartView.scoreLabel.text = highScore.asString()
            }
            gameStartView.difficultyDescription.text = "For those that learned all the Gojūon characters. Contains Dakuon and Handakuon Hiragana. "
        case .hard:
            if let highScore = persistenceManager.scores?.hard {
                gameStartView.scoreLabel.text = highScore.asString()
            }
            gameStartView.difficultyDescription.text = "For Hiragana pros! Contains all of the Hiragana types."
//            HiraganaManager.shared.hira.values.forEach({ hiraga += $0})
        }
    }
    
    private func layout(){
        gameStartView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameStartView.topAnchor.constraint(equalTo: view.topAnchor),
            gameStartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameStartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameStartView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
    //MARK: - Game Targets
extension ReviewViewController {
    @objc func startButtonTapped(){
        gameStartView.startButton.bounce(duration: 0.3, delay: 0, damping: 0.7, velocity: 0.5, completion: { [weak self] (_) in
            self?.startGame()
        })
    }
    
    private func startGame(){
        let destinationVC = GameViewController()
        destinationVC.mode = mode
        destinationVC.delegate = self
        destinationVC.modalPresentationStyle = .overFullScreen
        present(destinationVC, animated: false)
    }
    
    @objc func difficultyChanged(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            updateDifficulty(difficulty: .easy)
        case 1:
            updateDifficulty(difficulty: .medium)
        case 2:
            updateDifficulty(difficulty: .hard)
        default:
            return
        }
    }
}
    //MARK: - HighScore Delegate
extension ReviewViewController: HighScoreDelegate {
    func updateLabel(mode: Modes) {
        switch mode {
        case .easy:
            if let highScore = persistenceManager.scores?.easy {
                gameStartView.scoreLabel.text = highScore.asString()
            }
        case .medium:
            if let highScore = persistenceManager.scores?.medium {
                gameStartView.scoreLabel.text = highScore.asString()
            }
        case .hard:
            if let highScore = persistenceManager.scores?.hard {
                gameStartView.scoreLabel.text = highScore.asString()
            }
        }
    }
}
