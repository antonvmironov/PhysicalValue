//
//  AtomicPhysicalUnit.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 18.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation


public protocol AtomicPhysicalUnit: PhysicalUnit {

}



public extension AtomicPhysicalUnit {
    var compundPhysicalUnit: CompoundPhysicalUnit { return CompoundPhysicalUnit(kinds: [self.kind]) }
}