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

    func testTurnsBasedInit() {
        do {
            let angle = Angle(amount: 1.0, unit: .Turn)
            XCTAssertEqual(angle.amount, 1.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Turn)
        }

        do {
            let angle = Angle(turns: 1.0)
            XCTAssertEqual(angle.amount, 1.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Turn)
        }

        do {
            let angle: Angle = 1.0.of(.Turn)
            XCTAssertEqual(angle.amount, 1.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Turn)
        }

        do {
            let angle: Angle = 1.0 * .Turn
            XCTAssertEqual(angle.amount, 1.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Turn)
        }
    }
    
    func testRadiansBasedInit() {
        do {
            let angle = Angle(amount: M_PI, unit: .Radian)
            XCTAssertEqual(angle.amount, M_PI)
            XCTAssertEqual(angle.unit, Angle.Unit.Radian)
        }

        do {
            let angle = Angle(radians: M_PI)
            XCTAssertEqual(angle.amount, M_PI)
            XCTAssertEqual(angle.unit, Angle.Unit.Radian)
        }

        do {
            let angle: Angle = M_PI.of(.Radian)
            XCTAssertEqual(angle.amount, M_PI)
            XCTAssertEqual(angle.unit, Angle.Unit.Radian)
        }

        do {
            let angle: Angle = M_PI * .Radian
            XCTAssertEqual(angle.amount, M_PI)
            XCTAssertEqual(angle.unit, Angle.Unit.Radian)
        }
    }
    
    func testDegreesBasedInit() {
        do {
            let angle = Angle(amount: 90.0, unit: .Degree)
            XCTAssertEqual(angle.amount, 90.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Degree)
        }

        do {
            let angle = Angle(degrees: 90.0)
            XCTAssertEqual(angle.amount, 90.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Degree)
        }

        do {
            let angle: Angle = 90.0.of(.Degree)
            XCTAssertEqual(angle.amount, 90.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Degree)
        }

        do {
            let angle: Angle = 90.0 * .Degree
            XCTAssertEqual(angle.amount, 90.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Degree)
        }
    }
    
    func testGonsBasedInit() {
        do {
            let angle = Angle(amount: 100.0, unit: .Gon)
            XCTAssertEqual(angle.amount, 100.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Gon)
        }

        do {
            let angle: Angle = 100.0.of(.Gon)
            XCTAssertEqual(angle.amount, 100.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Gon)
        }

        do {
            let angle: Angle = 100.0 * .Gon
            XCTAssertEqual(angle.amount, 100.0)
            XCTAssertEqual(angle.unit, Angle.Unit.Gon)
        }
    }
    
    func testEquality() {
        let turnsAngle = Angle(turns: 0.5)
        let radiansAngle = Angle(radians: M_PI)
        let degreesAngle = Angle(degrees: 180.0)
        let gonsAngle = Angle(amount: 200.0, unit: .Gon)

        XCTAssertEqual(turnsAngle, radiansAngle)
        XCTAssertEqual(radiansAngle, degreesAngle)
        XCTAssertEqual(degreesAngle, gonsAngle)
        XCTAssertEqual(gonsAngle, turnsAngle)
    }

    func testTransform() {
        let knownUnits: [Angle.Unit] = [ .Turn, .Radian, .Degree, .Gon ]
        let angles: [Angle] = [ 0.25 * .Turn, M_PI_2 * .Radian, 90.0 * .Degree, 100.0 * .Gon ]

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
                newAngle.changeUnits(unit)
                XCTAssertEqual(newAngle.amount, angle.amount(unit: unit))
            }
        }
    }
}
