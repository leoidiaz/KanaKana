//
//  Type.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import Foundation

struct TypeStrings {
    static let gojūon = "gojūon"
    static let dakuon = "dakuon"
    static let handakuon = "handakuon"
    static let sokuon = "sokuon"
    static let yōon = "yōon"
}

class Type: Hashable {
    var id = UUID()
    var type: String
    var hiragana: [Hiragana]
    
    init(type: String, hiragana: [Hiragana]) {
      self.type = type
      self.hiragana = hiragana
    }

    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
    
    static func == (lhs: Type, rhs: Type) -> Bool {
      lhs.id == rhs.id
    }
}

extension Type {
    var order: Int {
        return [TypeStrings.gojūon, TypeStrings.dakuon, TypeStrings.handakuon, TypeStrings.yōon].firstIndex(of: type) ?? 0
    }
}
