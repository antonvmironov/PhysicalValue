//
//  PhysicalUnit.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 13.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public protocol _PhysicalUnit: CustomStringConvertible {
  // PhysicalUnit can only be used as a generic constraint. Intoducing superprotocol that can be used as type.
  // None should direcly conform to this protocol. Use PhysicalUnit instead. 
  var kind: PhysicalUnitKind { get }
  var name: String { get }
  var symbol: String { get }
  var wantsSpaceBetweenAmountAndSymbol: Bool { get }
  var compoundPhysicalUnit: CompoundPhysicalUnit { get }
  var hashValue: Int { get }
  
  func normal(amount: MathValue) -> MathValue
  func amount(normal: MathValue) -> MathValue
}

public extension _PhysicalUnit {
  var description: String { return self.symbol }
}

// MARK: -
public protocol PhysicalUnit: _PhysicalUnit, Hashable {
  associatedtype Value: PhysicalValue// where Value.Unit == Self
  var unitOfNormal: Self { get }
}
