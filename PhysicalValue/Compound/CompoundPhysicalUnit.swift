//
//  CompoundPhysicalUnit.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 14.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

import Foundation

public struct CompoundPhysicalUnit: PhysicalUnit {
  public var kinds: Bag<PhysicalUnitKind>
  
  public var kind: PhysicalUnitKind { return .compound(self) }
  public var unitOfNormal: CompoundPhysicalUnit {
    let resultKinds = self.kinds.reduce(Bag<PhysicalUnitKind>()) { (kindsAccumulator_, kindAndCounter) in
      var kindsAccumulator = kindsAccumulator_
      kindsAccumulator[kind] = (kindsAccumulator[kindAndCounter.value] ?? 0) + kindAndCounter.counter
      return kindsAccumulator
    }
    return CompoundPhysicalUnit(kinds: resultKinds)
  }
  public var hashValue: Int { return self.kinds.hashValue }
  
  public var description: String {
    let exportableKindsAndExponents = self.exportableKindsAndExponents
    
    let components = []
      + exportableKindsAndExponents.positiveExponent.map { $0.description }
      + exportableKindsAndExponents.negativeExponent.map { $0.description }
    
    return components.joined(separator: "\u{00D7}")
  }
  
  public var name: String {
    let exportableKindsAndExponents = self.exportableKindsAndExponents
    
    let components = []
      + exportableKindsAndExponents.positiveExponent.map { $0.name }
      + exportableKindsAndExponents.negativeExponent.map { $0.name }
    
    return components.joined(separator: "\u{00D7}")
  }
  
  public var symbol: String {
    let exportableKindsAndExponents = self.exportableKindsAndExponents
    
    let components = []
      + exportableKindsAndExponents.positiveExponent.map { $0.symbol }
      + exportableKindsAndExponents.negativeExponent.map { $0.symbol }
    
    return components.joined(separator: "\u{00D7}")
  }
  
  public var wantsSpaceBetweenAmountAndSymbol: Bool { return true }
  public var compoundPhysicalUnit: CompoundPhysicalUnit { return self }
  
  // MARK: Initializers
  public init(kinds: Bag<PhysicalUnitKind>) {
    self.kinds = kinds
  }
  
  // MARK: Methods
  public func normal(amount: MathValue) -> MathValue {
    var result = amount
    
    let kinsAndExponents = self.kinds.map { $0 }.sorted { $0.counter > $1.counter }
    for (kind, exponent) in kinsAndExponents {
      result = safePow(base: result, exponent: 1.0 / Double(exponent))
      result = kind.normal(amount: result)
      result = safePow(base: result, exponent: Double(exponent))
    }

    return result
  }

  public func amount(normal: MathValue) -> MathValue {
    var result = normal
    
    let kinsAndExponents = self.kinds.map { $0 }.sorted { $0.counter > $1.counter }
    for (kind, exponent) in kinsAndExponents {
      result = safePow(base: result, exponent: 1.0 / Double(exponent))
      result = kind.amount(normal: result)
      result = safePow(base: result, exponent: Double(exponent))
    }
    
    return result
  }
}

public func ==(lhs: CompoundPhysicalUnit, rhs: CompoundPhysicalUnit) -> Bool {
  return lhs.kinds == rhs.kinds
}

public func *(lhs: _PhysicalUnit, rhs: _PhysicalUnit) -> CompoundPhysicalUnit {
  let kinds = lhs.compoundPhysicalUnit.kinds + rhs.compoundPhysicalUnit.kinds
  return CompoundPhysicalUnit(kinds: kinds)
}

// MARK: -
private extension CompoundPhysicalUnit {
  struct Constants {
    static let digits: [Character] = [
                                       "\u{2070}", "\u{00B9}", "\u{00B2}", "\u{00B3}", "\u{2074}",
                                       "\u{2075}", "\u{2076}", "\u{2077}", "\u{2078}", "\u{2079}",
                                       ]
  }
  
  struct KindAndExponent: CustomStringConvertible {
    var kind: PhysicalUnitKind
    var exponent: Int
    var description: String {
      return "\(self.kind.descriptionOfUnit)\(self.string(fromExponent: self.exponent))"
    }
    var name: String {
      return "\(self.kind.nameOfUnit)\(self.string(fromExponent: self.exponent))"
    }
    var symbol: String {
      return "\(self.kind.symbolOfUnit)\(self.string(fromExponent: self.exponent))"
    }
    
    func string(fromExponent exponent: Int) -> String {
      guard 0 != exponent else { return String(Constants.digits[0]) }
      
      var exponentLeft = exponent
      var chars = [Character]()
      
      if exponentLeft < 0 {
        chars.append("-")
        exponentLeft = abs(exponentLeft)
      }
      while 0 != exponentLeft {
        chars.append(Constants.digits[exponentLeft % 10])
        exponentLeft /= 10
      }
      
      return String(chars)
    }
  }
  
  var exportableKindsAndExponents: (positiveExponent: [KindAndExponent], negativeExponent: [KindAndExponent]) {
    var positiveExponentKinds = [KindAndExponent]()
    var negativeExponentKinds = [KindAndExponent]()
    
    for (kind, exponent) in self.kinds {
      let kindAndExponent = KindAndExponent(kind: kind, exponent: exponent)
      if exponent > 0 {
        positiveExponentKinds.append(kindAndExponent)
      } else if exponent < 0 {
        negativeExponentKinds.append(kindAndExponent)
      }
    }
    
    func isOrderedBefore(lhs: KindAndExponent, _ rhs: KindAndExponent) -> Bool {
      if lhs.exponent == rhs.exponent {
        return lhs.kind.stringExportingPriority > rhs.kind.stringExportingPriority
      } else {
        return lhs.exponent > rhs.exponent
      }
    }
    
    positiveExponentKinds.sort(isOrderedBefore: isOrderedBefore)
    negativeExponentKinds.sort(isOrderedBefore: isOrderedBefore)
    return (positiveExponentKinds, negativeExponentKinds)
  }
}

// MARK: -
private extension PhysicalUnitKind {
  var stringExportingPriority: Int {
    switch self {
    case .angle: return 5
    case .length: return 10
    case .time: return 1
    case .speed: return 9
    case .volume: return 9
    case .compound: return 0
    }
  }
  
  static func isOrderedBeforeForStringExporting(lhs: PhysicalUnitKind, _ rhs: PhysicalUnitKind) -> Bool {
    return lhs.stringExportingPriority > rhs.stringExportingPriority
  }
}
