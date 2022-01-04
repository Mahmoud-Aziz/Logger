//
//  Codable + Extention.swift
//  Logger
//
//  Created by Mahmoud Aziz on 04/01/2022.
//

import Foundation


extension Encodable {
    var asDictionary: [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
        return try? JSONSerialization.jsonObject(with: data) as? [String : Any]
    }
}

extension Decodable {
    init?(dictionary: [String: Any]) {
        guard let data = try? JSONSerialization.data(withJSONObject: dictionary) else { return nil }
        guard let object = try? JSONDecoder().decode(Self.self, from: data) else { return nil }
        self = object
    }
}

extension UserDefaults {
 
    func setEncodablesAsArrayOfDictionaries<T: Encodable>(_ encodables: Array<T>, for key: String) {
        let arrayOfDictionaries = encodables.map({ $0.asDictionary })
        self.set(arrayOfDictionaries, forKey: key)
    }

    func getDecodablesFromArrayOfDictionaries<T: Decodable>(for key: String) -> [T]? {
        guard let arrayOfDictionaries = self.array(forKey: key) as? [[String: Any]] else {
            return nil
        }
        return arrayOfDictionaries.compactMap({ T(dictionary: $0) })
    }
}
