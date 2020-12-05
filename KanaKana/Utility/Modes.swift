//
//  Modes.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/4/20.
//

import Foundation

enum Modes: Int, CustomStringConvertible {
    case easy
    case medium
    case hard
    static func items() -> [String] {
        return [easy, medium, hard].map({$0.description})
    }
    var description: String {
        switch self {
        case .easy:
            return "Easy"
        case .medium:
            return "Medium"
        case .hard:
            return "Hard"
        }
    }
}
