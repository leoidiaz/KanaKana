//
//  DetailsViewController.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import UIKit

class DetailsViewController: UIViewController {
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        layout()
    }
    //MARK: - Properties
    var hiragana: Hiragana?
    lazy var detailsView = DetailsView()
    lazy var dismissButton = UIButton.makeButton(text: "Dismiss", color: .placeholderText, fontSize: 25)
    //MARK: - Methods
    private func setupView(){
        view.backgroundColor = .systemBackground
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchDown)
        view.addSubview(dismissButton)
        guard let kana = hiragana else { return }
        detailsView.kanaText.text = kana.kana
        detailsView.romajiText.text = kana.romaji
        detailsView.typeText.text = kana.type.uppercased()
        view.addSubview(detailsView)
    }
    private func layout(){
        detailsView.translatesAutoresizingMaskIntoConstraints = false
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dismissButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -35),
            dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            detailsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailsView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
        ])
    }
    @objc private func dismissButtonTapped(){
        dismiss(animated: true)
    }
}
