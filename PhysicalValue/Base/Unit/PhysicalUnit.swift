//
//  PhysicalUnit.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 13.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public protocol _PhysicalUnit: Hashable, CustomStringConvertible {
    var kind: PhysicalUnitKind { get }
    var name: String { get }
    var symbol: String { get }
    var wantsSpaceBetweenAmountAndSymbol: Bool { get }
    var compundPhysicalUnit: CompoundPhysicalUnit { get }
}

// MARK: -
public protocol PhysicalUnit: _PhysicalUnit {
    static func transform(fromAmount: MathValue, fromUnit: Self, toUnit: Self) -> MathValue

    func normal(amount: MathValue) -> MathValue
    func amount(normal: MathValue) -> MathValue
    
}

public extension PhysicalUnit {
    var description: String { return self.symbol }

    static func transform(fromAmount: MathValue, fromUnit: Self, toUnit: Self) -> MathValue {
        guard fromUnit != toUnit else { return fromAmount }
        let normal = fromUnit.normal(amount: fromAmount)
        let toAmount = toUnit.amount(normal: normal)
        return toAmount
    }
}
