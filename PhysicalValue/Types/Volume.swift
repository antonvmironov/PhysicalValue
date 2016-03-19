//
//  Volume.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 16.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public struct Volume: PhysicalValue {
    public typealias Unit = VolumeUnit

    //MARK: Properties - Owned
    public var amount: MathValue
    public var unit: Unit

    //MARK: Initializers
    public init(amount: MathValue, unit: Unit) {
        self.amount = amount
        self.unit = unit
    }
}

// MARK: -
public enum VolumeUnit: PhysicalUnit {
    // Normal is 1 Metre³

    case CubeOfLength(LengthUnit)
    case Liter

    public var kind: PhysicalUnitKind { return .Compound(self.compundPhysicalUnit) }
    public var hashValue: Int { return self.name.hashValue }

    public var name: String {
        switch self {
        case let .CubeOfLength(lengthUnit): return "\(lengthUnit.name)\u{00B3}"
        case .Liter: return "liter"
        }
    }

    public var symbol: String {
        switch self {
        case .CubeOfLength: return "m"
        case .Liter: return "l"
        }
    }

    public var wantsSpaceBetweenAmountAndSymbol: Bool {
        switch self {
        case .CubeOfLength: return false
        case .Liter: return false
        }
    }

    public var compundPhysicalUnit: CompoundPhysicalUnit {
        let lengthUnit: LengthUnit = eval {
            if case let .CubeOfLength(lengthUnit) = self {
                return lengthUnit
            } else {
                return .Metre
            }
        }
        let kinds = Bag(valuesAndCounts: (PhysicalUnitKind.Length(lengthUnit), 3))
        return CompoundPhysicalUnit(kinds: kinds)
    }

    public func normalFromAmount(value: MathValue) -> MathValue {
        switch self {
        case let .CubeOfLength(lengthUnit):
            return pow(lengthUnit.normalFromAmount(pow(value, 1.0 / 3.0)), 3.0)
        case .Liter:
            return value / 1000.0
        }
    }

    public func amountFromNormal(normal: MathValue) -> MathValue {
        switch self {
        case let .CubeOfLength(lengthUnit):
            return pow(lengthUnit.amountFromNormal(pow(normal, 1.0 / 3.0)), 3.0)
        case .Liter:
            return normal * 1000.0
        }
    }
}

public func ==(lhs: VolumeUnit, rhs: VolumeUnit) -> Bool {
    switch lhs {
    case let .CubeOfLength(leftUnit):
        if case let .CubeOfLength(rightUnit) = rhs { return leftUnit == rightUnit }
        else { return false }
    case .Liter:
        if case .Liter = rhs { return true }
        else { return false }
    }
}
