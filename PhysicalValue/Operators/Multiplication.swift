//
//  Multiplication.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 5/27/16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public func *(lhs: _PhysicalUnit, rhs: _PhysicalUnit) -> CompoundPhysicalUnit {
  let kinds = lhs.compoundPhysicalUnit.kinds + rhs.compoundPhysicalUnit.kinds
  return CompoundPhysicalUnit(kinds: kinds)
}

public func *(lhs: _PhysicalValue, rhs: _PhysicalValue) -> CompoundPhysicalValue {
  let normal = lhs.normal * rhs.normal
  let unit = lhs._unit * rhs._unit
  let amount = unit.amount(normal: normal)
  return CompoundPhysicalValue(amount: amount, unit: unit)
}

public func *<T: PhysicalValue>(lhs: T.Unit, rhs: MathValue) -> T {
  return T(amount: rhs, unit: lhs)
}

public func *<T: PhysicalValue>(lhs: MathValue, rhs: T) -> T {
  var result = rhs
  result.amount *= lhs
  return result
}

public func *<T: PhysicalValue>(lhs: T, rhs: MathValue) -> T {
  var result = lhs
  result.amount *= rhs
  return result
}

public func *(lhs: PhysicalUnitKind, rhs: PhysicalUnitKind) -> PhysicalUnitKind {
  return .compound(lhs.compoundPhysicalUnit * rhs.compoundPhysicalUnit)
}

public func *<T: PhysicalValue>(lhs: MathValue, rhs: T.Unit) -> T {
  return T(amount: lhs, unit: rhs)
}
