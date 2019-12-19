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
    private let container: Space.Container
    private let alphaComponent: ColorComponent
    public var alpha: Double { alphaComponent.value }
    
    private init(_ container: Space.Container, alpha: ColorComponent) {
        self.container = container
        self.alphaComponent = alpha
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<Space.Container, T>) -> T {
        return container[keyPath: keyPath]
    }
    
    public subscript(dynamicMember keyPath: KeyPath<Space.Container, ColorComponent>) -> Double {
        return container[keyPath: keyPath].value
    }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        (lhs.alpha, lhs.container) == (rhs.alpha, rhs.container)
    }
    
    public func map<Space: ColorSpace>(_ transform: (Self) -> Color<Space>) -> Color<Space> {
        transform(self)
    }

}

extension Color {
    
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
    
    public func with(red value: ColorComponent) -> Self {
        .init(container.with(red: value), alpha: alphaComponent)
    }
    
    public func with(green value: ColorComponent) -> Self {
        .init(container.with(green: value), alpha: alphaComponent)
    }
    
    public func with(blue value: ColorComponent) -> Self {
        .init(container.with(blue: value), alpha: alphaComponent)
    }
    
    public func mapToHSB() -> Color<HSB> {
        .init(container.hsb, alpha: alphaComponent)
    }
    
}

extension Color where Space == HSB {
    
    public init(hue: ColorComponent = 0,
                saturation: ColorComponent = 1,
                brightness: ColorComponent = 1,
                alpha: ColorComponent = 1) {
        self.init(HSB.Container(hue: hue, saturation: saturation, brightness: brightness), alpha: alpha)
    }
    
    public func with(hue value: ColorComponent) -> Self {
        .init(container.with(hue: value), alpha: alphaComponent)
    }
    
    public func with(saturation value: ColorComponent) -> Self {
        .init(container.with(saturation: value), alpha: alphaComponent)
    }
    
    public func with(brightness value: ColorComponent) -> Self {
        .init(container.with(brightness: value), alpha: alphaComponent)
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
    
}
