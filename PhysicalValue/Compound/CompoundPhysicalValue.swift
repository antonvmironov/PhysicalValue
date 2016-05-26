//
//  compoundPhysicalValue.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 5/26/16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public struct CompoundPhysicalValue: PhysicalValue {
  public typealias Unit = CompoundPhysicalUnit
  
  // MARK: Properties - Owned
  public var amount: MathValue
  public var unit: Unit
  
  // MARK: Initializers
  public init(amount: MathValue, unit: Unit) {
    self.amount = amount
    self.unit = unit
  }
}

public func *<T: PhysicalValue, U: PhysicalValue>(lhs: T, rhs: U) -> CompoundPhysicalValue {
  let normal = lhs.normal * rhs.normal
  let unit = lhs.unit * rhs.unit
  let amount = unit.amount(normal: normal)
  return CompoundPhysicalValue(amount: amount, unit: unit)
}
