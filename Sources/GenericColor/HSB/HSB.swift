//
//  HSB.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension HSB.Container: Codable {}

public enum HSB: ColorSpace {
  public struct Container: Equatable {
    public var hue: ColorComponent
    public var saturation: ColorComponent
    public var brightness: ColorComponent
  }
}

extension HSB.Container {
  public func with(
    hue: ColorComponent? = nil,
    saturation: ColorComponent? = nil,
    brightness: ColorComponent? = nil
  ) -> Self {
    .init(
      hue: hue ?? self.hue,
      saturation: saturation ?? self.saturation,
      brightness: brightness ?? self.brightness
    )
  }
}
