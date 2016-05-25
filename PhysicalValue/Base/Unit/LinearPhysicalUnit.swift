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
    func normal(amount: MathValue) -> MathValue {
        return amount * self.fractionOfNormal
    }

    func amount(normal: MathValue) -> MathValue {
        return normal / self.fractionOfNormal
    }
}
