//
//  HiraganaManager.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import Foundation

class HiraganaManager {
    var networkService = NetworkManager()
    static var shared = HiraganaManager()
    var allHira = [Hiragana]()
    var hira = [String:[Hiragana]]()
    func fetchHiragana(completion: @escaping(Result<[Type], KanaErrors>) -> Void){
        networkService.fetchHiragana { [weak self] (result) in
            switch result {
            case .success(let data):
                do {
                    let hiragana = try JSONDecoder().decode([Hiragana].self, from: data)
                    self?.allHira = hiragana
                    let sectionHiragana = Dictionary(grouping: hiragana, by: { String($0.type)})
                    self?.hira = sectionHiragana
                    var types = [Type]()
                    for i in sectionHiragana {
                        let type = Type(type: i.key, hiragana: i.value)
                        types.append(type)
                    }
                    let sortedTypes = types.sorted(by: {$0.order < $1.order})
                    return completion(.success(sortedTypes))
                } catch {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    return completion(.failure(.thrownError(error)))
                }
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(.failure(.thrownError(error)))
            }
        }
    }
}
