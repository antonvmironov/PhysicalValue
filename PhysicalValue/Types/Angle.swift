//
//  Angle.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 13.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public struct Angle: PhysicalValue {
  public typealias Unit = AngleUnit
  
  // MARK: Properties - Owned
  public var amount: MathValue
  public var unit: Unit
  
  // MARK: Properties - Derived
  public var turns: MathValue {
    get { return self.amount(unit: .turn) }
    set { self.setAmount(newValue, unit: .turn) }
  }
  
  public var radians: MathValue {
    get { return self.amount(unit: .radian) }
    set { self.setAmount(newValue, unit: .radian) }
  }
  
  public var degrees: MathValue {
    get { return self.amount(unit: .degree) }
    set { self.setAmount(newValue, unit: .degree) }
  }
  
  // MARK: Initializers
  public init(amount: MathValue, unit: Unit) {
    self.amount = amount
    self.unit = unit
  }
  
  public init(turns: MathValue) {
    self.amount = turns
    self.unit = .turn
  }
  
  public init(radians: MathValue) {
    self.amount = radians
    self.unit = .radian
  }
  
  public init(degrees: MathValue) {
    self.amount = degrees
    self.unit = .degree
  }
}


public enum AngleUnit: LinearPhysicalUnit, AtomicPhysicalUnit {
  case turn
  case radian
  case degree
  case gon
  
  public var kind: PhysicalUnitKind { return .angle(self) }
  public var unitOfNormal: AngleUnit { return .turn }
  public var fractionOfNormal: MathValue { return 1.0 / self.fullAngleValue }
  
  public var name: String {
    switch self {
    case .turn: return "turn"
    case .radian: return "radian"
    case .degree: return "degree"
    case .gon: return "gradian"
    }
  }
  
  public var symbol: String {
    switch self {
    case .turn: return "turns"
    case .radian: return "\u{33AD}"
    case .degree: return "\u{00B0}"
    case .gon: return "\u{1D4D}"
    }
  }
  
  public var wantsSpaceBetweenAmountAndSymbol: Bool {
    switch self {
    case .turn: return true
    case .radian: return false
    case .degree: return false
    case .gon: return false
    }
  }
  
  
  // MARK: Useful constants
  public var straightAngleValue: MathValue {
    switch self {
    case .turn: return 0.5
    case .radian: return M_PI
    case .degree: return 180.0
    case .gon: return 200.0
    }
  }
  
  public var fullAngleValue: MathValue {
    switch self {
    case .turn: return 1.0
    case .radian: return 2.0 * M_PI
    case .degree: return 360.0
    case .gon: return 400.0
    }
  }
}
