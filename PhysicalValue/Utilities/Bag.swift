//
//  Bag.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 14.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

// Slightly modified bag. Number of elements can go negative
public struct Bag<T : Hashable> : CollectionType, Hashable, ArrayLiteralConvertible {
    public typealias Generator = BagGenerator<T>
    public typealias Index = BagIndex<T>

    // MARK: Properties - Owned
    private var _contents: [T : Int]

    // MARK: Properties - Derived
    public var hashValue: Int { return self._contents.hashValue }
    public var isEmpty: Bool { return self._contents.isEmpty }
    public var count: Int { return self._contents.count }
    public var first: Generator.Element? { return self._contents.first }
    public var startIndex: Index { return Index(contentsIndex: self._contents.startIndex) }
    public var endIndex: Index { return Index(contentsIndex: self._contents.endIndex) }
    public subscript (position: Index) -> Generator.Element { return self._contents[position.contentsIndex] }
    public subscript (value: T) -> Int? {
        get { return self._contents[value] }
        set { self._contents[value] = newValue }
    }

    // MARK: Initializers
    private init(contents: [T : Int]) {
        self._contents = contents
    }

    public init() {
        self._contents = [:]
    }

    public init(arrayLiteral values: T...) {
        self._contents = [:]
        for value in values {
            self.insert(value)
        }
    }

    public init(valuesAndCounts: (T, Int)...) {
        self._contents = [:]
        for (value, count) in valuesAndCounts {
            self.updateCounterForValue(value, delta: count)
        }
    }

    // MARK: Methods
    @warn_unused_result
    public func generate() -> Generator {
        return Generator(contentsGenerator: self._contents.generate())
    }

    @warn_unused_result
    public func underestimateCount() -> Int {
        return self._contents.underestimateCount()
    }

    public mutating func updateCounterForValue(value: T, delta: Int) {
        guard 0 != delta else { return }
        let newCounter = (self._contents[value] ?? 0) + delta
        if 0 == newCounter {
            self._contents.removeValueForKey(value)
        } else {
            self._contents[value] = newCounter
        }
    }

    public mutating func insert(value: T) {
        self.updateCounterForValue(value, delta: 1)
    }

    public mutating func remove(value: T) {
        self.updateCounterForValue(value, delta: -1)
    }

    @warn_unused_result
    public func count(value: T) -> Int {
        return self[value] ?? 0
    }
}

// MARK: -
extension Bag: Unitable {
    public mutating func unionInPlace(other: Bag<T>) {
        self._contents.unionInPlace(other._contents)
    }

    @warn_unused_result
    public func union(other: Bag<T>) -> Bag<T> {
        return Bag(contents: self._contents.union(other._contents))
    }
}

public func ==<Element: Hashable>(lhs: Bag<Element>, rhs: Bag<Element>) -> Bool {
    return lhs._contents == rhs._contents
}

// MARK: -
public struct BagGenerator<T: Hashable> : GeneratorType {
    public typealias Element = (value: T, counter: Int)
    private typealias ContentsGenerator = DictionaryGenerator<T, Int>

    //MARK: Properties
    private var contentsGenerator: ContentsGenerator

    //MARK: Initializers
    private init(contentsGenerator: ContentsGenerator) {
        self.contentsGenerator = contentsGenerator
    }

    //MARK: Methods
    public mutating func next() -> Element? {
        return self.contentsGenerator.next()
    }
}

// MARK: -
public struct BagIndex<T: Hashable> : ForwardIndexType, Comparable {
    private var contentsIndex: DictionaryIndex<T, Int>

    //MARK: Initializers
    private init(contentsIndex: DictionaryIndex<T, Int>) {
        self.contentsIndex = contentsIndex
    }

    //MARK: Methods
    @warn_unused_result
    public func successor() -> BagIndex<T> {
        return BagIndex(contentsIndex: self.contentsIndex.successor())
    }
}

// MARK: -
public func ==<T: Hashable>(lhs: BagIndex<T>, rhs: BagIndex<T>) -> Bool {
    return lhs.contentsIndex == rhs.contentsIndex
}

// MARK: -
public func < <T: Hashable>(lhs: BagIndex<T>, rhs: BagIndex<T>) -> Bool {
    return lhs.contentsIndex < rhs.contentsIndex
}
