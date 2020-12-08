//
//  GameViewController.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class GameViewController: UIViewController {
    //MARK: - Properties
    lazy var gameView = GameView(frame: view.frame)
    var timer: Timer?
    var hiraga = [Hiragana]()
    var mode: Modes!
    let progress = Progress(totalUnitCount: 10)
    let hiraganaManager = HiraganaManager.shared
    var persistenceManager: PersistenceManager?
    lazy var score = 0 {
        didSet{
            gameView.scoreLabel.text = score.asString()
        }
    }
    
    weak var delegate: HighScoreDelegate?
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        setLayout()
    }
}

    //MARK: - Setup / Layout
extension GameViewController {
    private func setupView(){
        setHiragana(difficulty: mode)
        // Check we have a game mode else present user error
        gameView.restartButton.addTarget(self, action: #selector(restartGame), for: .touchDown)
        gameView.cancelButton.addTarget(self, action: #selector(cancelGame), for: .touchDown)
        view.addSubview(gameView)
        startGame()
    }
    
    private func setLayout(){
        gameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameView.topAnchor.constraint(equalTo: view.topAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setHiragana(difficulty: Modes){
        switch difficulty {
        case .easy:
            hiraga = hiraganaManager.hira[TypeStrings.gojūon]!
        case .medium:
            hiraga = hiraganaManager.hira[TypeStrings.dakuon]! + hiraganaManager.hira[TypeStrings.handakuon]!
        case .hard:
            hiraga = hiraganaManager.allHira
//            HiraganaManager.shared.hira.values.forEach({ hiraga += $0})
        }
        setupGame()
    }
}
    //MARK: - GameTargets
extension GameViewController {
    @objc func updateProgress(){
        progress.completedUnitCount -= 1
        gameView.timeProgress.setProgress(Float(progress.fractionCompleted), animated: true)
        if progress.completedUnitCount <= 1 {gameView.userInteractionToggle(false)}
        if progress.completedUnitCount <= 0 {
            timer?.invalidate()
            timer = nil
            checkHighScore(difficulty: mode)
            gameView.restartButton.isHidden = false
            return
        }
    }
    
    @objc func answerPressed(_ sender: UIButton){
        if sender.titleLabel?.text == hiraga[0].romaji {
            sender.backgroundColor = .green
            score += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak self] in
            sender.backgroundColor = .systemBackground
                self?.resetGame()
            }
        } else {
            sender.backgroundColor = .red
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25 ) { [weak self] in
            sender.backgroundColor = .systemBackground
                self?.resetGame()
            }
        }
    }
    
    private func startGame(){
        gameView.userInteractionToggle(true)
        progress.completedUnitCount = 10
        gameView.timeProgress.progress = Float(progress.fractionCompleted)
        gameView.scoreLabel.text = "0"
        score = 0
        timer = Timer.scheduledTimer(timeInterval: 0.600, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func restartGame(){
        gameView.restartButton.isHidden = true
        gameView.userInteractionToggle(true)
        progress.completedUnitCount = 10
        gameView.timeProgress.progress = Float(progress.fractionCompleted)
        resetGame()
        startGame()
    }
    
    private func setupGame(){
        timer?.invalidate()
        timer = nil
        hiraga.shuffle()
        gameView.shuffleLetterButtons()
        gameView.kanaLabel.text = hiraga.first?.kana
        gameView.restartButton.isHidden = true
        for i in 0..<gameView.answersView.letterButtons.count{
            gameView.answersView.letterButtons[i].setTitle(hiraga[i].romaji, for: .normal)
            gameView.answersView.letterButtons[i].addTarget(self, action: #selector(answerPressed(_:)), for: .touchUpInside)
        }
    }
    private func resetGame(){
        hiraga.shuffle()
        gameView.shuffleLetterButtons()
        gameView.kanaLabel.text = hiraga[0].kana
        for i in 0..<gameView.answersView.letterButtons.count{
            gameView.answersView.letterButtons[i].setTitle(hiraga[i].romaji, for: .normal)
        }
    }
    
    @objc func cancelGame(){
        timer?.invalidate()
        dismiss(animated: false)
    }
}

    //MARK: - Highscore
extension GameViewController {
    private func newHighScore(){
        let highscoreView = HighScoreView()
        highscoreView.highScoreNumber.text = score.asString()
        delegate?.updateLabel(mode: mode)
        view.addSubview(highscoreView)
    }
    
    private func checkHighScore(difficulty: Modes){
        if let highScore = persistenceManager?.scores {
            switch difficulty {
            case .easy:
                if score > highScore.easy {
                    persistenceManager?.updateScore(difficulty: .easy, from: score)
                    newHighScore()
                }
            case .medium:
                if score > highScore.medium {
                    persistenceManager?.updateScore(difficulty: .medium, from: score)
                    newHighScore()
                }
            case .hard:
                if score > highScore.hard {
                    persistenceManager?.updateScore(difficulty: .hard, from: score)
                    newHighScore()
                }
            }
        } else {
            persistenceManager?.createHighScore(newScore: score, difficulty: difficulty)
            newHighScore()
        }
    }
}
