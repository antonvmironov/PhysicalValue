//
//  PhysicalValue.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 13.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

public protocol _PhysicalValue: CustomStringConvertible {
  // PhysicalValue can only be used as a generic constraint. Intoducing superprotocol that can be used as type.
  // None should direcly conform to this protocol. Use PhysicalValue instead.
  var amount: MathValue { get set }
  var normal: MathValue { get }
  var _unit: _PhysicalUnit { get }
}

// MARK: -
public protocol PhysicalValue: _PhysicalValue, Equatable {
  associatedtype Unit: _PhysicalUnit
  
  var unit: Unit { get set }
  
  init(amount: MathValue, unit: Unit)
  
  mutating func change(toUnit: Unit)
  func changed(toUnit: Unit) -> Self
  func amount(unit: Unit) -> MathValue
  mutating func setAmount(_ amount: MathValue, unit: Unit)
}

public extension PhysicalValue {
  var normal: MathValue { return self.unit.normal(amount: self.amount) }
  var _unit: _PhysicalUnit { return self.unit }

  mutating func change(toUnit: Unit) {
    self.amount = self.amount(unit: toUnit)
    self.unit = toUnit
  }
  
  func changed(toUnit: Unit) -> Self {
    var result = self
    result.change(toUnit: toUnit)
    return result
  }
  
  func amount(unit: Unit) -> MathValue {
    let normal = self.unit.normal(amount: self.amount)
    return unit.amount(normal: normal)
  }
  
  mutating func setAmount(_ amount: MathValue, unit: Unit) {
    let normal = unit.normal(amount: amount)
    self.amount = self.unit.amount(normal: normal)
  }
  
  var description: String {
    let separator = self.unit.wantsSpaceBetweenAmountAndSymbol ? "\u{00A0}" : ""
    return "\(self.amount)\(separator)\(self.unit.symbol)"
  }
}

public func ==<T: PhysicalValue>(lhs: T, rhs: T) -> Bool {
  let leftNormal = lhs.unit.normal(amount: lhs.amount)
  let rightNormal = rhs.unit.normal(amount: rhs.amount)
  return isEqual(leftNormal, rightNormal)
}
