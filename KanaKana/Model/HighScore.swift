//
//  HighScore.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import Foundation

class HighScore: Codable {
    var easy: Int
    var medium: Int
    var hard: Int
    
    init(easy: Int = 0, medium: Int = 0, hard: Int = 0) {
        self.easy = easy
        self.medium = medium
        self.hard = hard
    }
}
