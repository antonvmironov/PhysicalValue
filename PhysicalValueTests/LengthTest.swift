//
//  LengthTest.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 5/27/16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation
import XCTest
@testable import PhysicalValue

class LengthTest: XCTestCase {
  func testMetreBasedInit() {
    do {
      let length = Length(amount: 1.0, unit: .metre)
      XCTAssertEqual(length.amount, 1.0)
      XCTAssertEqual(length.unit, Length.Unit.metre)
    }
    
    do {
      let length = Length(meters: 1.0)
      XCTAssertEqual(length.amount, 1.0)
      XCTAssertEqual(length.unit, Length.Unit.metre)
    }
    
    do {
      let length: Length = 1.0.of(.metre)
      XCTAssertEqual(length.amount, 1.0)
      XCTAssertEqual(length.unit, Length.Unit.metre)
    }
  }
}
