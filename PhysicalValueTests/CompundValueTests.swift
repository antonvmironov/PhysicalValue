//
//  compoundValueTests.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 5/26/16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation
import Foundation
import XCTest
@testable import PhysicalValue

class compoundValueTests: XCTestCase {
  func testMultiplication() {
    let lengthX: Length = 7.0 * .metre
    let lengthY: Length = 3.0 * .metre
    let lengthZ: Length = 5.0 * .metre
    
    let area = lengthX * lengthY
//    let area2 = (7.0 * LengthUnit.metre) * (3.0 * LengthUnit.metre)
    
    XCTAssertEqual(area.amount, 21.0)
    XCTAssertEqual(area.unit, CompoundPhysicalUnit(kinds: [.length(.metre), .length(.metre)]))

    let volume1 = area * lengthZ

    XCTAssertEqual(volume1.amount, 105.0)
    XCTAssertEqual(volume1.unit, CompoundPhysicalUnit(kinds: [.length(.metre), .length(.metre), .length(.metre)]))

//    let volume2 = lengthX * lengthY * lengthZ
//    
//    XCTAssertEqual(volume1, volume2)
//    XCTAssertEqual(volume2.amount, 105.0)
//    XCTAssertEqual(volume2.unit, CompoundPhysicalUnit(kinds: [.length(.metre), .length(.metre), .length(.metre)]))
    
    let time: Time = 11.0 * .second
    let lengthTimesTime = lengthX * time
    XCTAssertEqual(lengthTimesTime.amount, 77.0)
    XCTAssertEqual(lengthTimesTime.unit, CompoundPhysicalUnit(kinds: [.length(.metre), .time(.second)]))
  }
}
