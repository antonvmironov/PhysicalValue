//
//  Extensions.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 16.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

public func eval<T>(@noescape block: (Void) throws -> T) rethrows -> T {
    return try block()
}

// MARK: -
public extension CollectionType where Generator.Element: Hashable {
    var hashValue: Int {
        var counter = 100
        var accumulator = 0
        for element in self {
            guard counter > 0 else { break }
            accumulator = rotl(accumulator, 1) ^ element.hashValue
            counter += 1
        }
        return accumulator
    }
}

// MARK: -
public protocol Unitable {
    mutating func unionInPlace(other: Self)
    func union(other: Self) -> Self
}

// MARK: - Dictionary
public extension Dictionary where Value: Hashable {
    var hashValue: Int {
        var counter = 100
        var accumulator = 0
        for (key, value) in self {
            guard counter > 0 else { break }
            accumulator = rotl(accumulator, 1) ^ key.hashValue ^ value.hashValue
            counter += 1
        }
        return accumulator
    }
}

extension Dictionary: Unitable {
    public mutating func unionInPlace(other: Dictionary<Key, Value>) {
        for (key, value) in other {
            self[key] = value
        }
    }

    @warn_unused_result
    public func union(other: Dictionary<Key, Value>) -> Dictionary<Key, Value> {
        var result = Dictionary<Key, Value>(minimumCapacity: self.count + other.count)
        result.unionInPlace(self)
        result.unionInPlace(other)
        return result
    }
}

public func +=<U: Unitable>(inout lhs: U, rhs: U) {
    lhs.unionInPlace(rhs)
}

public func +<U: Unitable>(lhs: U, rhs: U) -> U {
    return lhs.union(rhs)
}

// MARK: -
func rotl(value: Int, _ shift: Int) -> Int {
    let numberOfBits = sizeof(Int) * 8
    let leftShift = shift % numberOfBits
    let rightShift = (numberOfBits - leftShift) % numberOfBits
    return (value << shift) | (value >> rightShift);
}
