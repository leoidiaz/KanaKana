//
//  ReviewViewController.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class ReviewViewController: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        layout()
        newHighScore()
    }
    
    //MARK: - Properties
    lazy var gameStartView = GameStartView(frame: view.frame)
    lazy var gameView = GameView(frame: view.frame)
    lazy var timer: Timer? = Timer()
    var hiraga = [Hiragana]()
    var mode: Modes = .easy
    let progress = Progress(totalUnitCount: 10)
    let persistenceManager = PersistenceManager()
    lazy var score = 0 {
        didSet{
            gameView.scoreLabel.text = score.asString()
        }
    }
    //MARK: - Init Methods
    private func setupView(){
        setHiragana(difficulty: .easy)
        gameStartView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchDown)
        gameStartView.difficultyControl.addTarget(self, action: #selector(difficultyChanged(_:)), for: .valueChanged)
        gameView.restartButton.addTarget(self, action: #selector(restartGame), for: .touchDown)
        gameView.cancelButton.addTarget(self, action: #selector(cancelGame), for: .touchDown)
        view.addSubview(gameStartView)
        view.addSubview(gameView)
    }
    private func setHiragana(difficulty: Modes){
        switch difficulty {
        case .easy:
            mode = .easy
            hiraga = HiraganaManager.shared.hira[TypeStrings.gojūon]!
            if let highScore = persistenceManager.scores?.easy {
                gameStartView.scoreLabel.text = highScore.asString()
            }
            gameStartView.difficultyDescription.text = "Ideal for beginners! Contains only Gojūon Hiragana."
        case .medium:
            mode = .medium
            hiraga = HiraganaManager.shared.hira[TypeStrings.dakuon]! + HiraganaManager.shared.hira[TypeStrings.handakuon]!
            if let highScore = persistenceManager.scores?.medium {
                gameStartView.scoreLabel.text = highScore.asString()
            }
            gameStartView.difficultyDescription.text = "For those that learned all the Gojūon characters. Contains Dakuon and Handakuon Hiragana. "
        case .hard:
            mode = .hard
            hiraga = HiraganaManager.shared.allHira
            if let highScore = persistenceManager.scores?.hard {
                gameStartView.scoreLabel.text = highScore.asString()
            }
            gameStartView.difficultyDescription.text = "For Hiragana pros! Contains all of the Hiragana types."
//            HiraganaManager.shared.hira.values.forEach({ hiraga += $0})
        }
        setupGame()
    }
    
    private func layout(){
        gameStartView.translatesAutoresizingMaskIntoConstraints = false
        gameView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gameStartView.topAnchor.constraint(equalTo: view.topAnchor),
            gameStartView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameStartView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameStartView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            gameView.topAnchor.constraint(equalTo: view.topAnchor),
            gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            gameView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

extension ReviewViewController {
    
    private func newHighScore(){
        let highscoreView = HighScoreView()
        highscoreView.highScoreNumber.text = score.asString()
        tabBarController?.view.addSubview(highscoreView)
    }
    
    private func checkHighScore(difficulty: Modes){
        if let highScore = persistenceManager.scores {
            switch difficulty {
            case .easy:
                if score > highScore.easy {
                    persistenceManager.updateScore(current: highScore, difficulty: .easy, from: score)
                    gameStartView.scoreLabel.text = score.asString()
                    newHighScore()
                }
            case .medium:
                if score > highScore.medium {
                    persistenceManager.updateScore(current: highScore, difficulty: .medium, from: score)
                    gameStartView.scoreLabel.text = score.asString()
                    newHighScore()
                }
            case .hard:
                if score > highScore.hard {
                    persistenceManager.updateScore(current: highScore, difficulty: .hard, from: score)
                    gameStartView.scoreLabel.text = score.asString()
                    newHighScore()
                }
            }
        } else {
            persistenceManager.createHighScore(newScore: score, difficulty: difficulty)
            gameStartView.scoreLabel.text = score.asString()
        }
    }
}


    //MARK: - Game Targets
extension ReviewViewController {
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
    
    @objc func startButtonTapped(){
        gameStartView.startButton.bounce(duration: 0.3, delay: 0, damping: 0.7, velocity: 0.5, completion: { [weak self] (_) in
            self?.startGame()
        })
    }
    
    private func startGame(){
        gameStartView.isHidden = true
        gameView.isHidden = false
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
        startButtonTapped()
    }
    
    @objc func cancelGame(){
        setupGame()
        gameStartView.isHidden = false
    }
    
    @objc func difficultyChanged(_ sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0:
            setHiragana(difficulty: .easy)
        case 1:
            setHiragana(difficulty: .medium)
        case 2:
            setHiragana(difficulty: .hard)
        default:
            return
        }
    }
    
}
    //MARK: - Game Setup / Reset
extension ReviewViewController{
    private func setupGame(){
        timer?.invalidate()
        timer = nil
        hiraga.shuffle()
        gameView.shuffleLetterButtons()
        gameView.kanaLabel.text = hiraga.first?.kana
        gameView.isHidden = true
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
}
