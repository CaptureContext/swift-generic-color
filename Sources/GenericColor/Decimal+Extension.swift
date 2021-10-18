//
//  Decimal+Extension.swift
//  GenericColor
//
//  Created by Maxim Krouk on 4/21/20.
//

import Foundation

extension Decimal {
  var nsDecimal: NSDecimalNumber { .init(decimal: self) }
  
  func rounded(
    _ roundingMode: NSDecimalNumber.RoundingMode
  ) -> Decimal { rounded(0, roundingMode) }
  
  func rounded(
    _ scale: Int,
    _ roundingMode: NSDecimalNumber.RoundingMode
  ) -> Decimal {
    var result = Decimal()
    var localCopy = self
    NSDecimalRound(
      &result,
      &localCopy,
      scale,
      roundingMode
    )
    return result
  }
  
  func truncatingRemainder(dividingBy value: Decimal) -> Decimal {
    self - value * (self / value).rounded(.down)
  }
}
