//
//  PersistenceManager.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import Foundation

class PersistenceManager {
    
    var scores: HighScore?
    
    init() {
        loadFromPersistence()
    }
    
    func createHighScore(newScore: Int, difficulty: Modes){
        switch difficulty {
        case .easy:
            scores = HighScore(easy: newScore)
        case .medium:
            scores = HighScore(medium: newScore)
        case .hard:
            scores = HighScore(hard: newScore)
        }
        saveToPersistence()
    }
    
    func updateScore(difficulty: Modes, from score: Int){
        switch difficulty{
        case .easy:
            scores?.easy = score
        case .medium:
            scores?.medium = score
        case .hard:
            scores?.hard = score
        }
        saveToPersistence()
    }
    
    //MARK: - JSON Methods
    private func saveToPersistence(){
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(scores)
            try data.write(to: fileURL())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func fileURL() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("HighScore.json")
        return fileURL
    }
    
    private func loadFromPersistence() {
        let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let decodedData = try decoder.decode(HighScore.self, from: data)
            scores = decodedData
        } catch {
            print(error.localizedDescription)
        }
    }
}
