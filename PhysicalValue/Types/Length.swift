//
//  Length.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 14.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public struct Length: PhysicalValue {
  public typealias Unit = LengthUnit
  
  // MARK: Properties - Owned
  public var amount: MathValue
  public var unit: Unit
  
  // MARK: Properties - Derived
  public var meters: MathValue {
    get { return self.amount(unit: .metre) }
    set { self.setAmount(newValue, unit: .metre) }
  }
  
  // MARK: Initializers
  public init(amount: MathValue, unit: Unit) {
    self.amount = amount
    self.unit = unit
  }
  
  public init(meters: MathValue) {
    self.amount = meters
    self.unit = .metre
  }
}

// MARK: -
public enum LengthUnit: LinearPhysicalUnit, AtomicPhysicalUnit {
  public typealias Value = Length

  // MARK: SI
  case metre
  case kilometre
  case centimetre
  case millimetre
  case micrometre
  case nanometre
  
  // MARK: Imperial
  case yard
  case mile
  case foot
  case inch
  
  // MARK: Astronomical
  case parsec
  case lightYear
  case lightSecond
  case astronomicalUnit
  
  // MARK: -
  public var kind: PhysicalUnitKind { return .length(self) }
  public var unitOfNormal: LengthUnit { return .metre }
  
  public var fractionOfNormal: MathValue {
    switch self {
    case .metre: return 1.0
    case .kilometre: return 1000.0
    case .centimetre: return 0.01
    case .millimetre: return pow(1.0, -3.0)
    case .micrometre: return pow(1.0, -6.0)
    case .nanometre: return pow(1.0, -9.0)
      
    case .yard: return LengthUnit.yardInMeters
    case .mile: return LengthUnit.yardInMeters * 1760.0
    case .foot: return LengthUnit.yardInMeters / 3.0
    case .inch: return LengthUnit.yardInMeters / 36.0
      
    case .parsec: return LengthUnit.parsecInMeters
    case .lightYear: return LengthUnit.lightYearInMeters
    case .lightSecond: return LengthUnit.lightSecondInMeters
    case .astronomicalUnit: return LengthUnit.astronomicalUnitInMeters
    }
  }
  
  public var name: String {
    switch self {
    case .metre: return "metre"
    case .kilometre: return "kilometre"
    case .centimetre: return "centimetre"
    case .millimetre: return "millimetre"
    case .micrometre: return "micrometre"
    case .nanometre: return "nanometre"
      
    case .yard: return "yard"
    case .mile: return "mile"
    case .foot: return "foot"
    case .inch: return "inch"
      
    case .parsec: return "parsec"
    case .lightYear: return "light year"
    case .lightSecond: return "light second"
    case .astronomicalUnit: return "Astronomical Unit"
    }
  }
  
  public var symbol: String {
    switch self {
    case .metre: return "m"
    case .kilometre: return "km"
    case .centimetre: return "cm"
    case .millimetre: return "mm"
    case .micrometre: return "\u{03BC}m"
    case .nanometre: return "nm"
      
    case .yard: return "yd"
    case .mile: return "mi"
    case .foot: return "ft"
    case .inch: return "in"
      
    case .parsec: return "parsec"
    case .lightYear: return "light year"
    case .lightSecond: return "light second"
    case .astronomicalUnit: return "AU"
    }
  }
  
  public var wantsSpaceBetweenAmountAndSymbol: Bool {
    switch self {
    case .metre: return false
    case .kilometre: return false
    case .centimetre: return false
    case .millimetre: return false
    case .micrometre: return false
    case .nanometre: return false
      
    case .yard: return false
    case .mile: return false
    case .foot: return false
    case .inch: return false
      
    case .parsec: return true
    case .lightYear: return true
    case .lightSecond: return true
    case .astronomicalUnit: return false
    }
  }
  
  // MARK: Meta
  private static let astronomicalUnitInMeters: MathValue = 149_597_870_700.0
  private static let lightSecondInMeters: MathValue = 299_792_458.0
  private static let lightYearInMeters: MathValue = LengthUnit.lightSecondInMeters * Time(amount: 1.0, unit: .year).seconds
  private static let parsecInMeters = (648_000.0 / M_PI) * LengthUnit.astronomicalUnitInMeters
  private static let yardInMeters: MathValue = 0.9144
}
