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

    //MARK: Properties - Owned
    public var amount: MathValue
    public var unit: Unit

    //MARK: Properties - Derived
    public var meters: MathValue {
        get { return self.amount(unit: .Metre) }
        set { self.setAmount(newValue, unit: .Metre) }
    }

    //MARK: Initializers
    public init(amount: MathValue, unit: Unit) {
        self.amount = amount
        self.unit = unit
    }
}


public enum LengthUnit: PhysicalUnit {
    // SI
    case Metre
    case Kilometre
    case Centimetre
    case Millimetre
    case Micrometre
    case Nanometre

    // Imperial
    case Yard
    case Mile
    case Foot
    case Inch

    // Astronomical
    case Parsec
    case LightYear
    case LightSecond
    case AstronomicalUnit

    public var fractionOfNormal: MathValue {
        switch self {
        case .Metre: return 1.0
        case .Kilometre: return 1000.0
        case .Centimetre: return 0.01
        case .Millimetre: return pow(1.0, -3.0)
        case .Micrometre: return pow(1.0, -6.0)
        case .Nanometre: return pow(1.0, -9.0)

        case .Yard: return LengthUnit.yardInMeters
        case .Mile: return LengthUnit.yardInMeters * 1760.0
        case .Foot: return LengthUnit.yardInMeters / 3.0
        case .Inch: return LengthUnit.yardInMeters / 36.0

        case .Parsec: return LengthUnit.parsecInMeters
        case .LightYear: return LengthUnit.lightYearInMeters
        case .LightSecond: return LengthUnit.lightSecondInMeters
        case .AstronomicalUnit: return LengthUnit.astronomicalUnitInMeters
        }
    }

    public var name: String {
        switch self {
        case .Metre: return "metre"
        case .Kilometre: return "kilometre"
        case .Centimetre: return "centimetre"
        case .Millimetre: return "millimetre"
        case .Micrometre: return "micrometre"
        case .Nanometre: return "nanometre"

        case .Yard: return "yard"
        case .Mile: return "mile"
        case .Foot: return "foot"
        case .Inch: return "inch"

        case .Parsec: return "parsec"
        case .LightYear: return "light year"
        case .LightSecond: return "light second"
        case .AstronomicalUnit: return "Astronomical Unit"
        }
    }

    public var symbol: String {
        switch self {
        case .Metre: return "m"
        case .Kilometre: return "km"
        case .Centimetre: return "cm"
        case .Millimetre: return "mm"
        case .Micrometre: return "\u{03BC}m"
        case .Nanometre: return "nm"

        case .Yard: return "yd"
        case .Mile: return "mi"
        case .Foot: return "ft"
        case .Inch: return "in"

        case .Parsec: return "parsec"
        case .LightYear: return "light year"
        case .LightSecond: return "light second"
        case .AstronomicalUnit: return "AU"
        }
    }

    public var wantsSpaceBetweenAmountAndSymbol: Bool {
        switch self {
        case .Metre: return false
        case .Kilometre: return false
        case .Centimetre: return false
        case .Millimetre: return false
        case .Micrometre: return false
        case .Nanometre: return false

        case .Yard: return false
        case .Mile: return false
        case .Foot: return false
        case .Inch: return false

        case .Parsec: return true
        case .LightYear: return true
        case .LightSecond: return true
        case .AstronomicalUnit: return false
        }
    }

    //MARK: Meta
    private static let astronomicalUnitInMeters: MathValue = 149_597_870_700.0
    private static let lightSecondInMeters: MathValue = 299_792_458.0
    private static let lightYearInMeters: MathValue = LengthUnit.lightSecondInMeters * Time(amount: 1.0, unit: .Year).seconds
    private static let parsecInMeters = (648_000.0 / M_PI) * LengthUnit.astronomicalUnitInMeters
    private static let yardInMeters: MathValue = 0.9144
}
