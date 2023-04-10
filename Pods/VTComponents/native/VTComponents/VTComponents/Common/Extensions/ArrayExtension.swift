//
//  ArrayExtension.swift
//  VTComponents-iOS
//
//  Created by Robin Rajasekaran on 20/04/20.
//

import Foundation

public extension Array {
    func enumerate(using closure: (Element, Int, inout Bool) -> Void) {
        var stop = false
        for index in stride(from: 0, to: count, by: 1) {
            closure(self[index], index, &stop)
            if stop {
                break
            }
        }
    }

    func reverseEnumerate(using closure: (Element, Int, inout Bool) -> Void) {
        var stop = false
        for index in stride(from: count - 1, through: 0, by: -1) {
            closure(self[index], index, &stop)
            if stop {
                break
            }
        }
    }

    func firstNElements(_ length: Int) -> [Element] {
        return Array(prefix(length))
    }

    func lastNElements(_ length: Int) -> [Element] {
        return Array(suffix(length))
    }

    func filtered(using block: (Element) -> Bool) -> (filtered: [Element], remaining: [Element]) {
        var filtered: [Element] = []
        let remaining: [Element] = reduce(into: []) { remaining, item in
            let shouldInclude = block(item)
            if shouldInclude {
                filtered.append(item)
            } else {
                remaining.append(item)
            }
        }
        return (filtered, remaining)
    }

    /// Returns the first element which satisfies the given condition
    func filterFirst(_ condition: (Element) throws -> Bool) rethrows -> Element? {
        for element in self where try condition(element) {
            return element
        }

        return nil
    }

    mutating func move(at currentIndex: Int, to newIndex: Int) {
        let element = self[currentIndex]
        remove(at: currentIndex)
        insert(element, at: newIndex)
    }

    /// Returns the indices of elements which satisfy the given condition
    func indices(where condition: (Element) throws -> Bool) rethrows -> [Int] {
        var result = [Int]()

        for index in 0 ..< count where try condition(self[index]) {
            result.append(index)
        }

        return result
    }

    /// Removes the first element which satisfies the given condition
    @inlinable mutating func removeFirst(_ condition: (Element) throws -> Bool) rethrows -> Element? {
        for (index, element) in enumerated() where try condition(element) {
            return remove(at: index)
        }
        return nil
    }

    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

public extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        return result
    }

    func index(of findingElement: Element, after startOffset: Int) -> Int? {
        for i in startOffset ..< count {
            if self[i] == findingElement {
                return i
            }
        }
        return nil
    }

    @discardableResult
    mutating func remove(_ element: Element) -> Element? {
        if let elementIndex = index(of: element) {
            return remove(at: elementIndex)
        }
        return nil
    }

    mutating func remove(contentsOf elementArray: [Element]) {
        for element in elementArray {
            if let elementIndex = index(of: element) {
                remove(at: elementIndex)
            }
        }
    }
}

public extension Collection where Element == String {
    func toString(separator: String = ",") -> String? {
        guard count > 0 else { return nil }
        var string = joined(separator: "'\(separator) '")
        string = "'" + string + "'"
        return string
    }
}
