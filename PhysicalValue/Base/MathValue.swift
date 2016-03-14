//
//  MathValue.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 13.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation


public typealias MathValue = Double


public func isEqual(lhs: MathValue, rhs: MathValue) -> Bool {
    //TODO: check doubles appropriately
    return lhs == rhs
}


public extension MathValue {
    func of<T: PhysicalValue>(unit: T.Unit) -> T {
        return T(amount: self, unit: unit)
    }
}
