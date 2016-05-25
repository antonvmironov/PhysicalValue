//
//  MathValue.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 13.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public typealias MathValue = Double

public func isEqual(_ lhs: MathValue,_ rhs: MathValue) -> Bool {
  //TODO: check doubles appropriately
  return lhs == rhs
}

public extension MathValue {
  func of<T: PhysicalValue>(_ unit: T.Unit) -> T {
    return T(amount: self, unit: unit)
  }
}

func safePow(base: MathValue, exponent: MathValue) -> MathValue {
  guard !isEqual(1.0, exponent) && !isEqual(0.0, base) else { return base }
  return pow(base, exponent)
}
