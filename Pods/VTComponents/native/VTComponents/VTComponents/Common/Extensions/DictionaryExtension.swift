//
//  DictionaryExtension.swift
//  VTComponents
//
//  Created by Robin Rajasekaran on 11/03/20.
//

import CoreGraphics // NOTE: imported for support of CGFloat in watchOS
import Foundation

public extension Dictionary {
    var allKeys: [Key] {
        return Array(keys)
    }

    var allValues: [Value] {
        return Array(values)
    }

    func intValue(forKey key: Key) -> Int? {
        if let value = self[key] as? Int {
            return value
        } else if let value = self[key] as? String, let valueInt = Int(value) {
            return valueInt
        }
        return nil
    }

    func uintValue(forKey key: Key) -> UInt? {
        if let value = self[key] as? UInt {
            return value
        } else if let value = self[key] as? String, !value.hasPrefix("-"), let valueInt = UInt(value) {
            return valueInt
        } else {
            return nil
        }
    }

    func doubleValue(forKey key: Key) -> Double? {
        if let value = self[key] as? Double {
            return value
        } else if let value = self[key] as? String, let valueDouble = Double(value) {
            return valueDouble
        }
        return nil
    }

    func cgFloatValue(forKey key: Key) -> CGFloat? {
        if let value = self[key] as? Double {
            return CGFloat(value)
        } else if let value = self[key] as? Int {
            return CGFloat(value)
        } else if let value = self[key] as? String, let doubleValue = Double(value) {
            return CGFloat(doubleValue)
        }
        return nil
    }

    func boolValue(forKey key: Key) -> Bool? {
        if let value = self[key] as? Bool {
            return value
        } else if let value = self[key] as? String {
            if value == "true" || value == "1" {
                return true
            } else if value == "false" || value == "0" {
                return false
            }
            return nil
        } else if let value = self[key] as? Int {
            return (value == 1)
        } else {
            return nil
        }
    }
}

public extension Dictionary where Key == String, Value == Any {
    func objects<T: Codable>() -> [T]? {
        guard let objects = try? JSONDecoder().decode([T].self, from: JSONSerialization.data(withJSONObject: self, options: [])) else { return nil }
        return objects
    }

    func object<T: Codable>() -> T? {
        guard let object = try? JSONDecoder().decode(T.self, from: JSONSerialization.data(withJSONObject: self, options: [])) else { return nil }
        return object
    }
}
