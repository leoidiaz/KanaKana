//
//  HighScoreViewController.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit
import Lottie

class HighScoreViewController: UIViewController {
    //MARK: - Properties
    var conffettiView: AnimationView?
    lazy var highScoreText = UILabel()
    lazy var highScoreNumber = UILabel()
    lazy var dismissButton = UIButton.makeButton(text: "Dismiss", color: .gris, fontSize: 40)
    var score: Int? = 22
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setLayout()
    }
    

    
    //MARK: - Methods
    func setupView(){
        view.backgroundColor = .systemBackground
        conffettiView = AnimationView(name: "7893-confetti-cannons")
//        conffettiView?.frame = view.bounds
        conffettiView?.contentMode = .scaleAspectFit
        conffettiView?.animationSpeed = 0.8
        conffettiView?.play(completion: { [weak self] (_) in
            self?.conffettiView?.play()
        })
        highScoreText.font = UIFont.systemFont(ofSize: 45)
        highScoreText.text = "New Highscore"
        highScoreNumber.text = score?.asString()
        highScoreNumber.font = UIFont.systemFont(ofSize: 90)
        
        view.addSubview(conffettiView!)
        view.addSubview(highScoreText)
        view.addSubview(highScoreNumber)
        view.addSubview(dismissButton)
    }
    func setLayout(){
        conffettiView?.translatesAutoresizingMaskIntoConstraints = false
        highScoreText.translatesAutoresizingMaskIntoConstraints = false
        highScoreNumber.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            conffettiView!.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conffettiView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            conffettiView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            highScoreText.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            highScoreText.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            highScoreNumber.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            highScoreNumber.topAnchor.constraint(equalToSystemSpacingBelow: highScoreText.bottomAnchor, multiplier: 6.0),
            
            dismissButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
