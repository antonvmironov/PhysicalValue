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

    //MARK: Properties - Owned
    public var amount: MathValue
    public var unit: Unit

    //MARK: Properties - Derived
    public var turns: Double {
        get { return self.amount(unit: .Turn) }
        set { self.setAmount(newValue, unit: .Turn) }
    }

    public var radians: Double {
        get { return self.amount(unit: .Radian) }
        set { self.setAmount(newValue, unit: .Radian) }
    }

    public var degrees: Double {
        get { return self.amount(unit: .Degree) }
        set { self.setAmount(newValue, unit: .Degree) }
    }

    //MARK: Initializers
    public init(amount: MathValue, unit: Unit) {
        self.amount = amount
        self.unit = unit
    }

    public init(turns: MathValue) {
        self.amount = turns
        self.unit = .Turn
    }

    public init(radians: MathValue) {
        self.amount = radians
        self.unit = .Radian
    }

    public init(degrees: MathValue) {
        self.amount = degrees
        self.unit = .Degree
    }
}


public enum AngleUnit: LinearPhysicalUnit, AtomicPhysicalUnit {
    // Normal is 1 Turn

    case Turn
    case Radian
    case Degree
    case Gon

    public var kind: PhysicalUnitKind { return .Angle(self) }

    public var fractionOfNormal: MathValue {
        return 1.0 / self.fullAngleValue
    }

    public var name: String {
        switch self {
        case .Turn: return "turn"
        case .Radian: return "radian"
        case .Degree: return "degree"
        case .Gon: return "gradian"
        }
    }

    public var symbol: String {
        switch self {
        case .Turn: return "turns"
        case .Radian: return "\u{33AD}"
        case .Degree: return "\u{00B0}"
        case .Gon: return "\u{1D4D}"
        }
    }

    public var wantsSpaceBetweenAmountAndSymbol: Bool {
        switch self {
        case .Turn: return true
        case .Radian: return false
        case .Degree: return false
        case .Gon: return false
        }
    }


    //MARK: Useful constants
    public var straightAngleValue: MathValue {
        switch self {
        case .Turn: return 0.5
        case .Radian: return M_PI
        case .Degree: return 180.0
        case .Gon: return 200.0
        }
    }

    public var fullAngleValue: MathValue {
        switch self {
        case .Turn: return 1.0
        case .Radian: return 2.0 * M_PI
        case .Degree: return 360.0
        case .Gon: return 400.0
        }
    }
}
