//
//  Division.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 5/27/16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation


public func /(lhs: _PhysicalUnit, rhs: _PhysicalUnit) -> CompoundPhysicalUnit {
  var kinds = lhs.compoundPhysicalUnit.kinds
  for (kind, counter) in rhs.compoundPhysicalUnit.kinds {
    kinds.updateCounter(forValue: kind, delta: -counter)
  }
  return CompoundPhysicalUnit(kinds: kinds)
}

public func /(lhs: _PhysicalValue, rhs: _PhysicalValue) -> CompoundPhysicalValue {
  let normal = lhs.normal / rhs.normal
  let unit = lhs._unit / rhs._unit
  let amount = unit.amount(normal: normal)
  return CompoundPhysicalValue(amount: amount, unit: unit)
}

public func /<T: PhysicalUnit>(lhs: T, rhs: MathValue) -> T.Value {
  return T.Value(amount: 1.0 / rhs, unit: lhs as! T.Value.Unit)
}

public func /(lhs: MathValue, rhs: _PhysicalUnit) -> CompoundPhysicalValue {
  let contents: [PhysicalUnitKind: Int] = [rhs.kind:-1]
  let kinds = Bag<PhysicalUnitKind>(contents: contents)
  let unit = CompoundPhysicalUnit(kinds: kinds)
  return CompoundPhysicalValue(amount: lhs, unit: unit)
}
