//
//  UserDefault.swift
//  NCN BackEnd
//
//  Created by raja-16327 on 18/04/23.
//

import Foundation

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    private let defaults = UserDefaults.standard

    private init() {}

    func saveIntData(key: String, value: Int) {
        defaults.set(value, forKey: key)
    }

    func saveStringData(key: String, value: String) {
        defaults.set(value, forKey: key)
    }

    func saveBoolData(key: String, value: Bool) {
        defaults.set(value, forKey: key)
    }

    func retrieveIntData(key: String) -> Int? {
        return defaults.integer(forKey: key)
    }

    func retrieveStringData(key: String) -> String? {
        return defaults.string(forKey: key)
    }

    func retriveBoolData(key: String) -> Bool? {
        return defaults.bool(forKey: key)
    }
}
