//
//  Color.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension Color: Codable where Space.Container: Codable {}

extension Color: _ExpressibleByColorLiteral where Space.Container: InitializableByRGBContainer {
    
    public init(_colorLiteralRed red: Float, green: Float, blue: Float, alpha: Float) {
        container = .init(from: RGB.Container(
            red   : .raw(red),
            green : .raw(green),
            blue  : .raw(blue))
        )
        self.alpha = .raw(alpha)
    }
    
}

@dynamicMemberLookup
public struct Color<Space: ColorSpace>: Equatable, KeyPathBuildable {
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
        self.init(RGB.Container(red: red, green: green, blue: blue), alpha: alpha)
    }
    
    @inlinable
    public init(
        white: ColorComponent = .max,
        alpha: ColorComponent = .max
    ) {
        self.init(red: white, green: white, blue: white, alpha: alpha)
    }
    
}

extension Color where Space == HSB {
    
    public init(
        hue: ColorComponent = .max,
        saturation: ColorComponent = .max,
        brightness: ColorComponent = .max,
        alpha: ColorComponent = .max
    ) {
        self.init(HSB.Container(hue: hue, saturation: saturation, brightness: brightness), alpha: alpha)
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
        self.init(CMYK.Container(cyan: cyan, magenta: magenta, yellow: yellow, key: key), alpha: alpha)
    }
    
}
