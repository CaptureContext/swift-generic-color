//
//  RGB.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension RGB.Container: Codable {}

public enum RGB: ColorSpace {
  public struct Container: Equatable {
    public var red: ColorComponent
    public var green: ColorComponent
    public var blue: ColorComponent
  }
}

extension RGB.Container {
  func hex(uppercase: Bool = false, hashTagPrefix: Bool = false) -> String {
    (hashTagPrefix ? "#" : "")
      .appending(red.hex(uppercase: uppercase))
      .appending(green.hex(uppercase: uppercase))
      .appending(blue.hex(uppercase: uppercase))
  }
  
  public func with(
    red: ColorComponent? = nil,
    green: ColorComponent? = nil,
    blue: ColorComponent? = nil
  ) -> Self {
    .init(
      red: red ?? self.red,
      green: green ?? self.green,
      blue: blue ?? self.blue
    )
  }
}
