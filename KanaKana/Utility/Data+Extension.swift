//
//  Data+Extension.swift
//  KanaKana
//
//  Created by Leonardo Diaz on 12/8/20.
//

import Foundation

extension Data {
    func decode<T:Decodable>(type:T.Type, decoder: JSONDecoder = JSONDecoder()) -> T? {
        return try? decoder.decode(type.self, from: self)
    }
}
