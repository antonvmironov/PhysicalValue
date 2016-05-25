//
//  PhysicalValue.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 13.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

public protocol PhysicalValue: Equatable, CustomStringConvertible {
    associatedtype Unit: PhysicalUnit

    var amount: MathValue { get set }
    var unit: Unit { get set }

    init(amount: MathValue, unit: Unit)

    mutating func change(toUnit: Unit)
    func amount(unit: Unit) -> MathValue
    mutating func setAmount(_ amount: MathValue, unit: Unit)
}

// MARK: -
public extension PhysicalValue {
    mutating func change(toUnit: Unit) {
        self.amount = Unit.transform(fromAmount: self.amount, fromUnit: self.unit, toUnit: toUnit)
        self.unit = unit
    }

    func amount(unit: Unit) -> MathValue {
        return Unit.transform(fromAmount: self.amount, fromUnit: self.unit, toUnit: unit)
    }
    
    mutating func setAmount(_ amount: MathValue, unit: Unit) {
        self.amount = Unit.transform(fromAmount: amount, fromUnit: unit, toUnit: self.unit)
    }

    var description: String {
        let separator = self.unit.wantsSpaceBetweenAmountAndSymbol ? "\u{00A0}" : ""
        return "\(self.amount)\(separator)\(self.unit.symbol)"
    }
}

public func *<T: PhysicalValue>(lhs: MathValue, rhs: T.Unit) -> T {
    return T(amount: lhs, unit: rhs)
}

public func ==<T: PhysicalValue>(lhs: T, rhs: T) -> Bool {
    if lhs.unit == rhs.unit {
        return isEqual(lhs.amount, rhs.amount)
    } else {
        let leftNormal = lhs.unit.normal(amount: lhs.amount)
        let rightNormal = rhs.unit.normal(amount: rhs.amount)
        return isEqual(leftNormal, rightNormal)
    }
}
