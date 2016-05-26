//
//  Volume.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 16.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public struct Volume: PhysicalValue {
  public typealias Unit = VolumeUnit
  
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
public enum VolumeUnit: PhysicalUnit {
  
  case cubeOfLength(LengthUnit)
  case liter
  
  public var kind: PhysicalUnitKind { return .compound(self.compoundPhysicalUnit) }
  public var unitOfNormal: VolumeUnit { return .cubeOfLength(.metre) }
  public var hashValue: Int { return self.name.hashValue }
  
  public var name: String {
    switch self {
    case let .cubeOfLength(lengthUnit): return "\(lengthUnit.name)\u{00B3}"
    case .liter: return "liter"
    }
  }
  
  public var symbol: String {
    switch self {
    case let .cubeOfLength(lengthUnit): return "\(lengthUnit.symbol)\u{00B3}"
    case .liter: return "l"
    }
  }
  
  public var wantsSpaceBetweenAmountAndSymbol: Bool {
    switch self {
    case .cubeOfLength: return false
    case .liter: return false
    }
  }
  
  public var compoundPhysicalUnit: CompoundPhysicalUnit {
    let lengthUnit: LengthUnit = eval {
      if case let .cubeOfLength(lengthUnit) = self {
        return lengthUnit
      } else {
        return .metre
      }
    }
    let kinds = Bag(valuesAndCounts: (lengthUnit.kind, 3))
    return CompoundPhysicalUnit(kinds: kinds)
  }
  
  public func normal(amount: MathValue) -> MathValue {
    switch self {
    case .cubeOfLength: return self.compoundPhysicalUnit.normal(amount: amount)
    case .liter: return amount / 1000.0
    }
  }
  
  public func amount(normal: MathValue) -> MathValue {
    switch self {
    case .cubeOfLength: return self.compoundPhysicalUnit.amount(normal: normal)
    case .liter: return normal * 1000.0
    }
  }
}

public func ==(lhs: VolumeUnit, rhs: VolumeUnit) -> Bool {
  switch lhs {
  case let .cubeOfLength(leftUnit):
    if case let .cubeOfLength(rightUnit) = rhs { return leftUnit == rightUnit }
    else { return false }
  case .liter:
    if case .liter = rhs { return true }
    else { return false }
  }
}
