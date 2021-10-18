//
//  String+RGB.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension BidirectionalCollection {
  func chunked(by size: Int = 1) -> [[Element]] {
    guard size > 0 else { return [Array(self)] }
    return stride(from: 0, to: count, by: size).map {
      let prev = index(startIndex, offsetBy: $0)
      let next = index(startIndex, offsetBy: Swift.min($0 + size, count))
      return Array(self[prev..<next])
    }
  }
  
}

extension String {
  func removingHexColorPrefix() -> String {
    guard first == "#" else { return self }
    var string = self
    string.remove(at: string.startIndex)
    return string
  }
  
  var isHexColorConvertable: Bool {
    guard (3...9).contains(count) else { return false }
    let string = removingHexColorPrefix().lowercased()
    
    let allowedSymbols = "0123456789abcdef"
    return string.allSatisfy({ allowedSymbols.contains($0) }) && [3,4,6,8].contains(string.count)
  }
  
  func scanHexRgba() -> (red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8)? {
    guard isHexColorConvertable else { return nil }
    var string = removingHexColorPrefix().lowercased()
    
    var chunks: [[Character]]
    switch string.count {
    case 3:
      string += "f"
      fallthrough
    case 4:
      chunks = string.reduce(into: "") {
        $0.append($1)
        $0.append($1)
      }.chunked(by: 2)
    case 6:
      string += "ff"
      fallthrough
    case 8:
      chunks = string.chunked(by: 2)
    default:
      return nil
    }
    let rgba = chunks.compactMap { UInt8(String($0), radix: 16) }
    return (rgba[0], rgba[1], rgba[2], rgba[3])
  }
}
