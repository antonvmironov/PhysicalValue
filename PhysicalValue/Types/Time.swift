//
//  Time.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 14.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public struct Time: PhysicalValue {
  public typealias Unit = TimeUnit
  
  // MARK: Properties - Owned
  public var amount: MathValue
  public var unit: Unit
  
  // MARK: Properties - Derived
  public var seconds: MathValue {
    get { return self.amount(unit: .second) }
    set { self.setAmount(newValue, unit: .second) }
  }
  
  // MARK: Initializers
  public init(amount: MathValue, unit: Unit) {
    self.amount = amount
    self.unit = unit
  }
}

// MARK: -
public enum TimeUnit: LinearPhysicalUnit, AtomicPhysicalUnit {
  public typealias Value = Time
  
  case year
  case day
  case hour
  case minute
  case second
  case millisecond
  case microsecond
  case nanosecond
  
  public var kind: PhysicalUnitKind { return .time(self) }
  public var unitOfNormal: TimeUnit { return .second }
  
  public var fractionOfNormal: MathValue {
    switch self {
    case .year: return 365.0 * 60.0 * 60.0
    case .day: return 24.0 * 60.0 * 60.0
    case .hour: return 60.0 * 60.0
    case .minute: return 60.0
    case .second: return 1.0
    case .millisecond: return 1.0 / pow(10.0, -3.0)
    case .microsecond: return 1.0 / pow(10.0, -6.0)
    case .nanosecond: return 1.0 / pow(10.0, -9.0)
    }
  }
  
  public var name: String {
    switch self {
    case .year: return "year"
    case .day: return "day"
    case .hour: return "hour"
    case .minute: return "minute"
    case .second: return "second"
    case .millisecond: return "millisecond"
    case .microsecond: return "microsecond"
    case .nanosecond: return "nanosecond"
    }
  }
  
  public var symbol: String {
    switch self {
    case .year: return "year"
    case .day: return "day"
    case .hour: return "hour"
    case .minute: return "minute"
    case .second: return "s"
    case .millisecond: return "ms"
    case .microsecond: return "\u{03BC}s"
    case .nanosecond: return "ns"
    }
  }
  
  public var wantsSpaceBetweenAmountAndSymbol: Bool {
    switch self {
    case .year: return true
    case .day: return true
    case .hour: return true
    case .minute: return true
    case .second: return false
    case .millisecond: return false
    case .microsecond: return false
    case .nanosecond: return false
    }
  }
}
