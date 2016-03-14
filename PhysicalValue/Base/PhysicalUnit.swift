//
//  PhysicalUnit.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 13.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation


public protocol PhysicalUnit: Hashable, CustomStringConvertible {
    var fractionOfNormal: MathValue { get }
    var name: String { get }
    var symbol: String { get }
    var wantsSpaceBetweenAmountAndSymbol: Bool { get }

    func normalFromAmount(value: MathValue) -> MathValue
    func amountFromNormal(normal: MathValue) -> MathValue

    static func transform(fromAmount: MathValue, fromUnit: Self, toUnit: Self) -> MathValue
}


public extension PhysicalUnit {
    var description: String { return self.symbol }

    func normalFromAmount(value: MathValue) -> MathValue {
        return value * self.fractionOfNormal
    }

    func amountFromNormal(normal: MathValue) -> MathValue {
        return normal / self.fractionOfNormal
    }

    static func transform(fromAmount: MathValue, fromUnit: Self, toUnit: Self) -> MathValue {
        guard fromUnit != toUnit else { return fromAmount }
        let normal = fromUnit.normalFromAmount(fromAmount)
        let toAmount = toUnit.amountFromNormal(normal)
        return toAmount
    }
}
