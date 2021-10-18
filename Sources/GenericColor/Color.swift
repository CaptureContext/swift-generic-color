//
//  Color.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension Color: Codable where Space.Container: Codable {}

extension Color: _ExpressibleByColorLiteral where Space.Container: InitializableByRGBContainer {
  public init(
    _colorLiteralRed red: Float,
    green: Float,
    blue: Float,
    alpha: Float
  ) {
    container = .init(
      from: RGB.Container(
        red   : .raw(red),
        green : .raw(green),
        blue  : .raw(blue)
      )
    )
    self.alpha = .raw(alpha)
  }
  
}

@dynamicMemberLookup
public struct Color<Space: ColorSpace>: Equatable {
  internal var container: Space.Container
  public var alpha: ColorComponent
  
  internal init(_ container: Space.Container, alpha: ColorComponent) {
    self.container = container
    self.alpha = alpha
  }
  
  public subscript<T>(dynamicMember keyPath: KeyPath<Space.Container, T>) -> T {
    get { container[keyPath: keyPath] }
  }
  
  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Space.Container, T>) -> T {
    get { container[keyPath: keyPath] }
    set { container[keyPath: keyPath] = newValue }
  }
  
  public static func ==(lhs: Self, rhs: Self) -> Bool {
    (lhs.alpha, lhs.container) == (rhs.alpha, rhs.container)
  }
}

extension Color where Space.Container: RGBProvider {
  public func hex(uppercase: Bool = false, hashTagPrefix: Bool = false) -> String {
    container.rgb.hex(
      uppercase: uppercase,
      hashTagPrefix: hashTagPrefix
    ).appending(alpha.hex(uppercase: uppercase))
  }
}

extension Color: RGBAInitializable where Space == RGB {
  public init(
    red: ColorComponent,
    green: ColorComponent,
    blue: ColorComponent,
    alpha: ColorComponent = .max
  ) {
    self.init(
      RGB.Container(
        red: red,
        green: green,
        blue: blue
      ),
      alpha: alpha
    )
  }
  
  @inlinable
  public init(
    white value: ColorComponent = .max,
    alpha: ColorComponent = .max
  ) {
    self.init(
      red: value,
      green: value,
      blue: value,
      alpha: alpha
    )
  }
  
  public func with(
    red: ColorComponent? = nil,
    green: ColorComponent? = nil,
    blue: ColorComponent? = nil,
    alpha: ColorComponent? = nil
  ) -> Self {
    .init(
      red: red ?? self.red,
      green: green ?? self.green,
      blue: blue ?? self.blue,
      alpha: alpha ?? self.alpha
    )
  }
}

extension Color where Space == HSB {
  public init(
    hue: ColorComponent = .max,
    saturation: ColorComponent = .max,
    brightness: ColorComponent = .max,
    alpha: ColorComponent = .max
  ) {
    self.init(
      HSB.Container(
        hue: hue,
        saturation: saturation,
        brightness: brightness
      ),
      alpha: alpha
    )
  }
  
  public func with(
    hue: ColorComponent? = nil,
    saturation: ColorComponent? = nil,
    brightness: ColorComponent? = nil,
    alpha: ColorComponent? = nil
  ) -> Self {
    .init(
      hue: hue ?? self.hue,
      saturation: saturation ?? self.saturation,
      brightness: brightness ?? self.brightness,
      alpha: alpha ?? self.alpha
    )
  }
}

extension Color where Space == CMYK {
  public init(
    cyan: ColorComponent = .min,
    magenta: ColorComponent = .min,
    yellow: ColorComponent = .min,
    key: ColorComponent = .min,
    alpha: ColorComponent = .max
  ) {
    self.init(
      CMYK.Container(
        cyan: cyan,
        magenta: magenta,
        yellow: yellow,
        key: key
      ),
      alpha: alpha
    )
  }
  
  public func with(
    cyan: ColorComponent? = nil,
    magenta: ColorComponent? = nil,
    yellow: ColorComponent? = nil,
    key: ColorComponent? = nil,
    alpha: ColorComponent? = nil
  ) -> Self {
    .init(
      cyan: cyan ?? self.cyan,
      magenta: magenta ?? self.magenta,
      yellow: yellow ?? self.yellow,
      key: key ?? self.key,
      alpha: alpha ?? self.alpha
    )
  }
}
