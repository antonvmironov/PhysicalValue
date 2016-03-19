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

    func normalFromAmount(value: MathValue) -> MathValue
    func amountFromNormal(normal: MathValue) -> MathValue
    
}

// MARK: -
public extension PhysicalUnit {
    var description: String { return self.symbol }

    static func transform(fromAmount: MathValue, fromUnit: Self, toUnit: Self) -> MathValue {
        guard fromUnit != toUnit else { return fromAmount }
        let normal = fromUnit.normalFromAmount(fromAmount)
        let toAmount = toUnit.amountFromNormal(normal)
        return toAmount
    }
}
