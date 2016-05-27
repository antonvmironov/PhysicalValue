//
//  DivisionTest.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 5/27/16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation
import XCTest
@testable import PhysicalValue

class DivisionTest: XCTestCase {
  func testUnitDividedByConstant() {
    do {
      let constant: MathValue = 5.0
      let unit = Length.Unit.metre
      let result = unit / constant
      XCTAssertEqual(result.amount, 1.0 / 5.0)
      XCTAssertEqual(result.unit, Length.Unit.metre)
    }
  }
}
