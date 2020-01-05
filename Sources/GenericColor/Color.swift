//
//  Color.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension Color: Codable where Space.Container: Codable {}

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
        container.rgb.hex(uppercase: uppercase, hashTagPrefix: hashTagPrefix) +
        .init(Int(alpha.byteValue), radix: 16, uppercase: uppercase)
    }
    
}

extension Color {
    
    /// Returns a new object with a new aplha value
    public func with(alpha value: ColorComponent) -> Self {
        .init(container, alpha: value)
    }
    
}

extension Color: RGBAInitializable where Space == RGB {
    
    public init(red: ColorComponent = 1,
                green: ColorComponent = 1,
                blue: ColorComponent = 1,
                alpha: ColorComponent = 1) {
        self.init(RGB.Container(red: red, green: green, blue: blue), alpha: alpha)
    }
    
    /// Returns a new object with a new red value
    public func with(red value: ColorComponent) -> Self {
        .init(container.with(red: value), alpha: alpha)
    }
    
    /// Returns a new object with a new green value
    public func with(green value: ColorComponent) -> Self {
        .init(container.with(green: value), alpha: alpha)
    }
    
    /// Returns a new object with a new blue value
    public func with(blue value: ColorComponent) -> Self {
        .init(container.with(blue: value), alpha: alpha)
    }
    
    public func map<T: ColorSpace>(to space: T.Type) -> Color<T>
    where T.Container: InitializableByRGBContainer {
        .init(space.Container.init(from: container), alpha: alpha)
    }
    
}

extension Color where Space == HSB {
    
    public init(hue: ColorComponent = 0,
                saturation: ColorComponent = 1,
                brightness: ColorComponent = 1,
                alpha: ColorComponent = 1) {
        self.init(HSB.Container(hue: hue, saturation: saturation, brightness: brightness), alpha: alpha)
    }
    
    /// Returns a new object with a new hue value
    public func with(hue value: ColorComponent) -> Self {
        .init(container.with(hue: value), alpha: alpha)
    }
    
    /// Returns a new object with a new saturation value
    public func with(saturation value: ColorComponent) -> Self {
        .init(container.with(saturation: value), alpha: alpha)
    }
    
    /// Returns a new object with a new brightness value
    public func with(brightness value: ColorComponent) -> Self {
        .init(container.with(brightness: value), alpha: alpha)
    }
    
    public func map<Space: ColorSpace>(to space: Space.Type) -> Color<Space>
    where Space.Container: InitializableByHSBContainer {
        .init(space.Container.init(from: container), alpha: alpha)
    }
    
}

extension Color where Space == CMYK {
    
    public init(cyan: ColorComponent = 0,
                magenta: ColorComponent = 0,
                yellow: ColorComponent = 0,
                key: ColorComponent = 0,
                alpha: ColorComponent = 1) {
        self.init(CMYK.Container(cyan: cyan, magenta: magenta, yellow: yellow, key: key), alpha: alpha)
    }
    
    /// Returns a new object with a new cyan value
    public func with(cyan value: ColorComponent) -> Self {
        .init(container.with(cyan: value), alpha: alpha)
    }
    
    /// Returns a new object with a new magenta value
    public func with(magenta value: ColorComponent) -> Self {
        .init(container.with(magenta: value), alpha: alpha)
    }
    
    /// Returns a new object with a new yellow value
    public func with(yellow value: ColorComponent) -> Self {
        .init(container.with(yellow: value), alpha: alpha)
    }
    
    /// Returns a new object with a new key value
    public func with(key value: ColorComponent) -> Self {
        .init(container.with(key: value), alpha: alpha)
    }
    
    public func map<Space: ColorSpace>(to space: Space.Type) -> Color<Space>
    where Space.Container: InitializableByCMYKContainer {
        .init(space.Container.init(from: container), alpha: alpha)
    }
    
}
