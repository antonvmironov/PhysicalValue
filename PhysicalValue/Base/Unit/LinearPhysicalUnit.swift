//
//  LinearPhysicalUnit.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 18.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation


public protocol LinearPhysicalUnit: PhysicalUnit {
    var fractionOfNormal: MathValue { get }
}


public extension LinearPhysicalUnit {
    func normalFromAmount(value: MathValue) -> MathValue {
        return value * self.fractionOfNormal
    }

    func amountFromNormal(normal: MathValue) -> MathValue {
        return normal / self.fractionOfNormal
    }
}
