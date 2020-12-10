//
//  HiraganaManager.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import Foundation

class HiraganaManager: NetworkManager {
    static var shared = HiraganaManager()
    var allHira = [Hiragana]()
    var hira = [String:[Hiragana]]()
    func fetchHiragana(completion: @escaping(Result<[Type], KanaErrors>) -> Void){
        guard let url = EndPoint.baseURL else {
            completion(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        perform(request) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.sortHira(data, completion: completion)
            case .failure(let error):
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(.failure(.thrownError(error)))
            }
        }
    }
}

extension HiraganaManager {
    private func sortHira(_ data: Data, completion:@escaping (Result<[Type], KanaErrors>)-> Void){
        guard let hiragana = data.decode(type: [Hiragana].self) else {
            completion(.failure(.unableToDecode))
            return
        }
        allHira = hiragana
        let sectionHiragana = Dictionary(grouping: hiragana, by: { String($0.type)})
        hira = sectionHiragana
        var types = [Type]()
        for i in sectionHiragana {
            let type = Type(type: i.key, hiragana: i.value)
            types.append(type)
        }
        let sortedTypes = types.sorted(by: {$0.order < $1.order})
        return completion(.success(sortedTypes))
    }
}
