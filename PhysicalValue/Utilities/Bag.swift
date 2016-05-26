//
//  Bag.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 14.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

// Slightly modified bag. Number of elements can go negative
public struct Bag<T : Hashable> : Collection, Hashable, ArrayLiteralConvertible {
  public typealias Iterator = BagIterator<T>
  public typealias Index = BagIndex<T>
  
  // MARK: Properties - Owned
  private var _contents: [T : Int]
  
  // MARK: Properties - Derived
  public var hashValue: Int { return self._contents.hashValue }
  public var isEmpty: Bool { return self._contents.isEmpty }
  public var count: Int { return self._contents.count }
  public var first: Iterator.Element? {
    guard let element = self._contents.first else { return nil }
    return Iterator.Element(value: element.key, counter: element.value)
  }
  public var startIndex: Index { return Index(contentsIndex: self._contents.startIndex) }
  public var endIndex: Index { return Index(contentsIndex: self._contents.endIndex) }
  public subscript (position: Index) -> Iterator.Element {
    let element = self._contents[position.contentsIndex]
    return Iterator.Element(value: element.key, counter: element.value)
  }
  public subscript (value: T) -> Int? {
    get { return self._contents[value] }
    set { self._contents[value] = newValue }
  }
  public var underestimatedCount: Int { return self._contents.underestimatedCount }
  
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
      self.insert(value: value)
    }
  }
  
  public init(valuesAndCounts: (T, Int)...) {
    self._contents = [:]
    for (value, count) in valuesAndCounts {
      self.updateCounter(forValue: value, delta: count)
    }
  }
  
  // MARK: Methods
  @warn_unused_result
  public func makeIterator() -> Iterator {
    return Iterator(contentsIterator: self._contents.makeIterator())
  }
  
  public mutating func updateCounter(forValue value: T, delta: Int) {
    guard 0 != delta else { return }
    let newCounter = (self._contents[value] ?? 0) + delta
    if 0 == newCounter {
      self._contents.removeValue(forKey:value)
    } else {
      self._contents[value] = newCounter
    }
  }
  
  public mutating func insert(value: T) {
    self.updateCounter(forValue: value, delta: 1)
  }
  
  public mutating func remove(value: T) {
    self.updateCounter(forValue: value, delta: -1)
  }
  
  @warn_unused_result
  public func count(value: T) -> Int {
    return self[value] ?? 0
  }
  
  public func index(after i: Index) -> Index {
    return Index(contentsIndex: self._contents.index(after: i.contentsIndex))
  }
}

// MARK: -
extension Bag: Unitable {
  public mutating func formUnion(other: Bag) {
    for (kind, counter) in other {
      self[kind] = (self[kind] ?? 0) + counter
    }
  }
  
  @warn_unused_result
  public func union(other: Bag<T>) -> Bag<T> {
    var result = Bag<T>()
    result.formUnion(other: self)
    result.formUnion(other: other)
    return result
  }
}

public func ==<Element: Hashable>(lhs: Bag<Element>, rhs: Bag<Element>) -> Bool {
  return lhs._contents == rhs._contents
}

// MARK: -
public struct BagIterator<T: Hashable> : IteratorProtocol {
  public typealias Element = (value: T, counter: Int)
  private typealias ContentsIterator = DictionaryIterator<T, Int>
  
  // MARK: Properties
  private var contentsIterator: ContentsIterator
  
  // MARK: Initializers
  private init(contentsIterator: ContentsIterator) {
    self.contentsIterator = contentsIterator
  }
  
  // MARK: Methods
  public mutating func next() -> Element? {
    guard let element = self.contentsIterator.next() else { return nil }
    return Element(value: element.key, counter: element.value)
  }
}

// MARK: -
public struct BagIndex<T: Hashable> : Comparable {
  private var contentsIndex: DictionaryIndex<T, Int>
  
  // MARK: Initializers
  private init(contentsIndex: DictionaryIndex<T, Int>) {
    self.contentsIndex = contentsIndex
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
