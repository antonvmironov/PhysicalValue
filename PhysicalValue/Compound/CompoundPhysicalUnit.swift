//
//  CompoundPhysicalUnit.swift
//  PhysicalValue
//
//  Created by Anton Mironov on 14.03.16.
//  Copyright © 2016 Anton Mironov. All rights reserved.
//

public struct CompoundPhysicalUnit: _PhysicalUnit {
    public var kinds: Bag<PhysicalUnitKind>

    public var kind: PhysicalUnitKind { return .Compound(self) }

    public var hashValue: Int { return self.kind.hashValue }

    public var description: String {
        let exportableKindsAndExponents = self.exportableKindsAndExponents

        let components = []
            + exportableKindsAndExponents.positiveExponent.map { $0.description }
            + exportableKindsAndExponents.negativeExponent.map { $0.description }

        return components.joinWithSeparator("\u{00D7}")
    }

    public var name: String {
        let exportableKindsAndExponents = self.exportableKindsAndExponents

        let components = []
            + exportableKindsAndExponents.positiveExponent.map { $0.name }
            + exportableKindsAndExponents.negativeExponent.map { $0.name }

        return components.joinWithSeparator("\u{00D7}")
    }

    public var symbol: String {
        let exportableKindsAndExponents = self.exportableKindsAndExponents

        let components = []
            + exportableKindsAndExponents.positiveExponent.map { $0.symbol }
            + exportableKindsAndExponents.negativeExponent.map { $0.symbol }

        return components.joinWithSeparator("\u{00D7}")
    }

    public var wantsSpaceBetweenAmountAndSymbol: Bool { return true }
    public var compundPhysicalUnit: CompoundPhysicalUnit { return self }
}

public func ==(lhs: CompoundPhysicalUnit, rhs: CompoundPhysicalUnit) -> Bool {
    return lhs.kinds == rhs.kinds
}

public func *<T: PhysicalUnit, U: PhysicalUnit>(lhs: T, rhs: U) -> CompoundPhysicalUnit {
    let kinds = lhs.compundPhysicalUnit.kinds + rhs.compundPhysicalUnit.kinds
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
            return "\(self.kind.descriptionOfUnit)\(self.stringFromExponent(self.exponent))"
        }
        var name: String {
            return "\(self.kind.nameOfUnit)\(self.stringFromExponent(self.exponent))"
        }
        var symbol: String {
            return "\(self.kind.symbolOfUnit)\(self.stringFromExponent(self.exponent))"
        }

        func stringFromExponent(exponent: Int) -> String {
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

        positiveExponentKinds.sortInPlace(isOrderedBefore)
        negativeExponentKinds.sortInPlace(isOrderedBefore)
        return (positiveExponentKinds, negativeExponentKinds)
    }
}

// MARK: -
private extension PhysicalUnitKind {
    var stringExportingPriority: Int {
        switch self {
        case .Angle: return 5
        case .Length: return 10
        case .Time: return 1
        case .Compound: return 0
        }
    }

    static func isOrderedBeforeForStringExporting(lhs: PhysicalUnitKind, _ rhs: PhysicalUnitKind) -> Bool {
        return lhs.stringExportingPriority > rhs.stringExportingPriority
    }
}
