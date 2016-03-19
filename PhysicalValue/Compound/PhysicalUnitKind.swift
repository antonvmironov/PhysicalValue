//
//  PhysicalValueKind.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 14.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

public enum PhysicalUnitKind: Hashable {

    // MARK: Atomics
    case Angle(AngleUnit)
    case Length(LengthUnit)
    case Time(TimeUnit)

    // MARK: Compound
    // No need to add more compound units here. Express them in .Compound of atomics instead of adding.
    case Compound(CompoundPhysicalUnit)

    // MARK: Methods
    public var hashValue: Int {
        switch self {
        case let .Angle(unit): return unit.hashValue
        case let .Length(unit): return unit.hashValue
        case let .Time(unit): return unit.hashValue
        case let .Compound(unit): return unit.hashValue
        }
    }

    public var comoundPhysicalUnit: CompoundPhysicalUnit {
        if case let .Compound(unit) = self {
            return unit
        } else {
            return CompoundPhysicalUnit(kinds: [self])
        }
    }

    public var descriptionOfUnit: String {
        switch self {
        case let .Angle(unit): return unit.description
        case let .Length(unit): return unit.description
        case let .Time(unit): return unit.description
        case let .Compound(unit): return unit.description
        }
    }

    public var nameOfUnit: String {
        switch self {
        case let .Angle(unit): return unit.name
        case let .Length(unit): return unit.name
        case let .Time(unit): return unit.name
        case let .Compound(unit): return unit.name
        }
    }

    public var symbolOfUnit: String {
        switch self {
        case let .Angle(unit): return unit.symbol
        case let .Length(unit): return unit.symbol
        case let .Time(unit): return unit.symbol
        case let .Compound(unit): return unit.symbol
        }
    }
}

public func == (lhs: PhysicalUnitKind, rhs: PhysicalUnitKind) -> Bool {
    switch lhs {
    case .Angle:
        if case .Angle = rhs { return true }
        else { return false }
    case .Length:
        if case .Length = rhs { return true }
        else { return false }
    case .Time:
        if case .Time = rhs { return true }
        else { return false }
    case let .Compound(leftUnit):
        if case let .Compound(rightUnit) = rhs { return leftUnit == rightUnit }
        else { return false }
    }
}
