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
  // No need to add more compound units here. Express them in .Compound of atomics instead of adding.
  case compound(CompoundPhysicalUnit)
  
  // MARK: Methods
  public var hashValue: Int {
    switch self {
    case let .angle(unit): return unit.hashValue
    case let .length(unit): return unit.hashValue
    case let .time(unit): return unit.hashValue
    case let .compound(unit): return unit.hashValue
    }
  }
  
  public var comoundPhysicalUnit: CompoundPhysicalUnit {
    if case let .compound(unit) = self {
      return unit
    } else {
      return CompoundPhysicalUnit(kinds: [self])
    }
  }
  
  public var descriptionOfUnit: String {
    switch self {
    case let .angle(unit): return unit.description
    case let .length(unit): return unit.description
    case let .time(unit): return unit.description
    case let .compound(unit): return unit.description
    }
  }
  
  public var nameOfUnit: String {
    switch self {
    case let .angle(unit): return unit.name
    case let .length(unit): return unit.name
    case let .time(unit): return unit.name
    case let .compound(unit): return unit.name
    }
  }
  
  public var symbolOfUnit: String {
    switch self {
    case let .angle(unit): return unit.symbol
    case let .length(unit): return unit.symbol
    case let .time(unit): return unit.symbol
    case let .compound(unit): return unit.symbol
    }
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
  case let .compound(leftUnit):
    if case let .compound(rightUnit) = rhs { return leftUnit == rightUnit }
    else { return false }
  }
}
