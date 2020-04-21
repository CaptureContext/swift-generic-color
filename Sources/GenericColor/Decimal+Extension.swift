//
//  Decimal+Extension.swift
//  GenericColor
//
//  Created by Maxim Krouk on 4/21/20.
//

import Foundation

extension Decimal {
    func rounded(_ scale: Int, _ roundingMode: NSDecimalNumber.RoundingMode) -> Decimal {
        var result = Decimal()
        var localCopy = self
        NSDecimalRound(&result, &localCopy, scale, roundingMode)
        return result
    }
}
