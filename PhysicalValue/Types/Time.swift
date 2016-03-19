//
//  Time.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 14.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public struct Time: PhysicalValue {
    public typealias Unit = TimeUnit

    //MARK: Properties - Owned
    public var amount: MathValue
    public var unit: Unit

    //MARK: Properties - Derived
    public var seconds: MathValue {
        get { return self.amount(unit: .Second) }
        set { self.setAmount(newValue, unit: .Second) }
    }

    //MARK: Initializers
    public init(amount: MathValue, unit: Unit) {
        self.amount = amount
        self.unit = unit
    }
}

// MARK: -
public enum TimeUnit: LinearPhysicalUnit, AtomicPhysicalUnit {
    // Normal is 1 Second

    case Year
    case Day
    case Hour
    case Minute
    case Second
    case Millisecond
    case Microsecond
    case Nanosecond

    public var kind: PhysicalUnitKind { return .Time(self) }

    public var fractionOfNormal: MathValue {
        switch self {
        case .Year: return 365.0 * 60.0 * 60.0
        case .Day: return 24.0 * 60.0 * 60.0
        case .Hour: return 60.0 * 60.0
        case .Minute: return 60.0
        case .Second: return 1.0
        case .Millisecond: return 1.0 / pow(10.0, -3.0)
        case .Microsecond: return 1.0 / pow(10.0, -6.0)
        case .Nanosecond: return 1.0 / pow(10.0, -9.0)
        }
    }

    public var name: String {
        switch self {
        case .Year: return "year"
        case .Day: return "day"
        case .Hour: return "hour"
        case .Minute: return "minute"
        case .Second: return "second"
        case .Millisecond: return "millisecond"
        case .Microsecond: return "microsecond"
        case .Nanosecond: return "nanosecond"
        }
    }

    public var symbol: String {
        switch self {
        case .Year: return "year"
        case .Day: return "day"
        case .Hour: return "hour"
        case .Minute: return "minute"
        case .Second: return "s"
        case .Millisecond: return "ms"
        case .Microsecond: return "\u{03BC}s"
        case .Nanosecond: return "ns"
        }
    }

    public var wantsSpaceBetweenAmountAndSymbol: Bool {
        switch self {
        case .Year: return true
        case .Day: return true
        case .Hour: return true
        case .Minute: return true
        case .Second: return false
        case .Millisecond: return false
        case .Microsecond: return false
        case .Nanosecond: return false
        }
    }
}
