//
//  Speed.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 5/25/16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public struct Speed: PhysicalValue {
  public typealias Unit = SpeedUnit

  // MARK: Properties - Owned
  public var amount: MathValue
  public var unit: Unit
  
  // MARK: Initializers
  public init(amount: MathValue, unit: Unit) {
    self.amount = amount
    self.unit = unit
  }
}

// MARK: -
public enum SpeedUnit: PhysicalUnit {
  // Normal is 1 Metre per 1 Second
  
  case lengthPerTime(lengthUnit: LengthUnit, timeUnit: TimeUnit)
  
  public var kind: PhysicalUnitKind { return .compound(self.compundPhysicalUnit) }
  public var hashValue: Int { return self.name.hashValue }
  
  public var name: String {
    switch self {
    case let .lengthPerTime(lengthUnit, timeUnit):
      return "\(lengthUnit.name) / \(timeUnit.name)"
    }
  }
  
  public var symbol: String {
    switch self {
    case let .lengthPerTime(lengthUnit, timeUnit):
      return "\(lengthUnit.symbol)/\(timeUnit.symbol)"
    }
  }
  
  public var wantsSpaceBetweenAmountAndSymbol: Bool {
    switch self {
    case .lengthPerTime: return false
    }
  }
  
  public var compundPhysicalUnit: CompoundPhysicalUnit {
    let lengthUnit: LengthUnit
    let timeUnit: TimeUnit
    switch self {
    case let .lengthPerTime(lengthUnit_, timeUnit_):
      lengthUnit = lengthUnit_
      timeUnit = timeUnit_
    }
    
    let kinds = Bag(valuesAndCounts: (lengthUnit.kind, 1), (timeUnit.kind, -1))
    return CompoundPhysicalUnit(kinds: kinds)
  }
  
  public func normal(amount: MathValue) -> MathValue {
    switch self {
    case .lengthPerTime:
      return self.compundPhysicalUnit.normal(amount: amount)
    }
  }
  
  public func amount(normal: MathValue) -> MathValue {
    switch self {
    case .lengthPerTime:
      return self.compundPhysicalUnit.amount(normal: normal)
    }
  }
}

public func ==(lhs: SpeedUnit, rhs: SpeedUnit) -> Bool {
  switch lhs {
  case let .lengthPerTime(leftLengthUnit, leftTimeUnit):
    if case let .lengthPerTime(rightLengthUnit, rightTimeUnit) = rhs {
      return leftLengthUnit == rightLengthUnit && leftTimeUnit == rightTimeUnit
    }
    else { return false }
  }
}
