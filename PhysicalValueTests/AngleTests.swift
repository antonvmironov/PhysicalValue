//
//  AngleTests.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 13.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation
import XCTest
@testable import PhysicalValue


class AngleTests: XCTestCase {
  
  func testturnsBasedInit() {
    do {
      let angle = Angle(amount: 1.0, unit: .turn)
      XCTAssertEqual(angle.amount, 1.0)
      XCTAssertEqual(angle.unit, Angle.Unit.turn)
    }
    
    do {
      let angle = Angle(turns: 1.0)
      XCTAssertEqual(angle.amount, 1.0)
      XCTAssertEqual(angle.unit, Angle.Unit.turn)
    }
    
    do {
      let angle: Angle = 1.0.of(.turn)
      XCTAssertEqual(angle.amount, 1.0)
      XCTAssertEqual(angle.unit, Angle.Unit.turn)
    }
    
    do {
      let angle: Angle = 1.0 * .turn
      XCTAssertEqual(angle.amount, 1.0)
      XCTAssertEqual(angle.unit, Angle.Unit.turn)
    }
  }
  
  func testradiansBasedInit() {
    do {
      let angle = Angle(amount: M_PI, unit: .radian)
      XCTAssertEqual(angle.amount, M_PI)
      XCTAssertEqual(angle.unit, Angle.Unit.radian)
    }
    
    do {
      let angle = Angle(radians: M_PI)
      XCTAssertEqual(angle.amount, M_PI)
      XCTAssertEqual(angle.unit, Angle.Unit.radian)
    }
    
    do {
      let angle: Angle = M_PI.of(.radian)
      XCTAssertEqual(angle.amount, M_PI)
      XCTAssertEqual(angle.unit, Angle.Unit.radian)
    }
    
    do {
      let angle: Angle = M_PI * .radian
      XCTAssertEqual(angle.amount, M_PI)
      XCTAssertEqual(angle.unit, Angle.Unit.radian)
    }
  }
  
  func testdegreesBasedInit() {
    do {
      let angle = Angle(amount: 90.0, unit: .degree)
      XCTAssertEqual(angle.amount, 90.0)
      XCTAssertEqual(angle.unit, Angle.Unit.degree)
    }
    
    do {
      let angle = Angle(degrees: 90.0)
      XCTAssertEqual(angle.amount, 90.0)
      XCTAssertEqual(angle.unit, Angle.Unit.degree)
    }
    
    do {
      let angle: Angle = 90.0.of(.degree)
      XCTAssertEqual(angle.amount, 90.0)
      XCTAssertEqual(angle.unit, Angle.Unit.degree)
    }
    
    do {
      let angle: Angle = 90.0 * .degree
      XCTAssertEqual(angle.amount, 90.0)
      XCTAssertEqual(angle.unit, Angle.Unit.degree)
    }
  }
  
  func testgonsBasedInit() {
    do {
      let angle = Angle(amount: 100.0, unit: .gon)
      XCTAssertEqual(angle.amount, 100.0)
      XCTAssertEqual(angle.unit, Angle.Unit.gon)
    }
    
    do {
      let angle: Angle = 100.0.of(.gon)
      XCTAssertEqual(angle.amount, 100.0)
      XCTAssertEqual(angle.unit, Angle.Unit.gon)
    }
    
    do {
      let angle: Angle = 100.0 * .gon
      XCTAssertEqual(angle.amount, 100.0)
      XCTAssertEqual(angle.unit, Angle.Unit.gon)
    }
  }
  
  func testEquality() {
    let turnsAngle = Angle(turns: 0.5)
    let radiansAngle = Angle(radians: M_PI)
    let degreesAngle = Angle(degrees: 180.0)
    let gonsAngle = Angle(amount: 200.0, unit: .gon)
    
    XCTAssertEqual(turnsAngle, radiansAngle)
    XCTAssertEqual(radiansAngle, degreesAngle)
    XCTAssertEqual(degreesAngle, gonsAngle)
    XCTAssertEqual(gonsAngle, turnsAngle)
  }
  
  func testTransform() {
    let knownUnits: [Angle.Unit] = [ .turn, .radian, .degree, .gon ]
    let angles: [Angle] = [ 0.25 * .turn, M_PI_2 * .radian, 90.0 * .degree, 100.0 * .gon ]
    
    for leftAngle in angles {
      for rightAngle in angles {
        XCTAssertEqual(leftAngle, rightAngle)
        for units in knownUnits {
          XCTAssertEqual(leftAngle.amount(unit: units), rightAngle.amount(unit: units))
        }
      }
    }
    
    for angle in angles {
      print("\(angle)")
      
      for unit in knownUnits {
        var newAngle = angle
        newAngle.change(toUnit: unit)
        XCTAssertEqual(newAngle.amount, angle.amount(unit: unit))
      }
    }
  }
}
