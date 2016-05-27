//
//  MultiplicationTest.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 5/27/16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation
import XCTest
@testable import PhysicalValue

class MultiplicationTest: XCTestCase {
  func testValueTimesValue() {
    let lengthX: Length = 7.0 * .metre
    let lengthY: Length = 3.0 * .metre
    let lengthZ: Length = 5.0 * .metre
    
    let area = lengthX * lengthY
    //    let area2 = (7.0 * LengthUnit.metre) * (3.0 * LengthUnit.metre)
    
    XCTAssertEqual(area.amount, 21.0)
    XCTAssertEqual(LengthUnit.metre * LengthUnit.metre, CompoundPhysicalUnit(kinds: [.length(.metre), .length(.metre)]))
    XCTAssertEqual(area.unit, CompoundPhysicalUnit(kinds: [.length(.metre), .length(.metre)]))
    
    let volume1 = area * lengthZ
    
    XCTAssertEqualWithAccuracy(volume1.amount, 105.0, accuracy: 0.000001)
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
  
  func testValueTimesUnit() {
    do {
      let length: Length = 7.0 * .metre
      XCTAssertEqual(length.amount, 7.0)
      XCTAssertEqual(length.unit, Length.Unit.metre)
    }
    
    do {
      let length: Length = .metre * 3
      XCTAssertEqual(length.amount, 3.0)
      XCTAssertEqual(length.unit, Length.Unit.metre)
    }
  }
  
  func testValueTimesConstant() {
    do {
      let length: Length = 7.0 * .metre
      let constant: MathValue = 3.0
      let result = constant * length
      XCTAssertEqual(result.amount, 21.0)
      XCTAssertEqual(result.unit, Length.Unit.metre)
    }
    
    do {
      let length: Length = .metre * 5.0
      let constant: MathValue = 11.0
      let result = constant * length
      XCTAssertEqual(result.amount, 55.0)
      XCTAssertEqual(result.unit, Length.Unit.metre)
    }
  }
}
