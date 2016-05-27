//
//  PhysicalValueKind.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 14.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

public enum PhysicalUnitKind: Hashable {
  
  // MARK: Atomics
  case angle(AngleUnit)
  case length(LengthUnit)
  case time(TimeUnit)
  
  // MARK: Compound
  case volume(VolumeUnit)
  case speed(SpeedUnit)
  
  case compound(CompoundPhysicalUnit)
  
  // MARK: Methods
  public var unit: _PhysicalUnit {
    switch self {
    case let .angle(unit): return unit
    case let .length(unit): return unit
    case let .time(unit): return unit
    case let .volume(unit): return unit
    case let .speed(unit): return unit
    case let .compound(unit): return unit
    }
  }
  
  public var hashValue: Int { return self.unit.hashValue }
  
  public var compoundPhysicalUnit: CompoundPhysicalUnit {
    if case let .compound(unit) = self {
      return unit.compoundPhysicalUnit
    } else {
      return CompoundPhysicalUnit(kinds: [self])
    }
  }
  
  public var descriptionOfUnit: String { return unit.description }
  public var nameOfUnit: String { return self.unit.name }
  public var symbolOfUnit: String { return self.unit.symbol }
  
  public func normal(amount: MathValue) -> MathValue {
    return self.unit.normal(amount: amount)
  }
  
  public func amount(normal: MathValue) -> MathValue {
    return self.unit.amount(normal: normal)
  }
}

public func == (lhs: PhysicalUnitKind, rhs: PhysicalUnitKind) -> Bool {
  switch lhs {
  case .angle:
    if case .angle = rhs { return true }
    else { return false }
  case .length:
    if case .length = rhs { return true }
    else { return false }
  case .time:
    if case .time = rhs { return true }
    else { return false }
  case .volume:
    if case .volume = rhs { return true }
    else { return false }
  case .speed:
    if case .speed = rhs { return true }
    else { return false }
  case let .compound(leftUnit):
    if case let .compound(rightUnit) = rhs { return leftUnit == rightUnit }
    else { return false }
  }
}
