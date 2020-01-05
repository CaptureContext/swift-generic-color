//
//  HSB+Conversions.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension HSB.Container: InitializableByHSBContainer, HSBProvider {
    
    public init(from container: Self) {
        self = container
    }
    
    public var hsb: HSB.Container { self }
    
}

extension HSB.Container: InitializableByRGBContainer, RGBProvider {
    
    public init(from container: RGB.Container) {
        self = container.hsb
    }
    
    /// Returns rgb container, equivalent to the current hsb one.
    ///
    /// https://en.wikipedia.org/wiki/HSL_and_HSV
    public var rgb: RGB.Container {
        let hsb = (hue: hue.value, saturation: saturation.value, brightness: brightness.value)
        let c = hsb.brightness * hsb.saturation
        let x = c * (1 - abs((hsb.hue * 6).truncatingRemainder(dividingBy: 2) - 1))
        let m = hsb.brightness - c
        
        func value(_ v: Double) -> ColorComponent { .raw(v + m) }
        switch hsb.hue * 6 {
        case 0..<1, 6 : return .init(red: value(c), green: value(x), blue: value(0))
        case 1..<2    : return .init(red: value(x), green: value(c), blue: value(0))
        case 2..<3    : return .init(red: value(0), green: value(c), blue: value(x))
        case 3..<4    : return .init(red: value(0), green: value(x), blue: value(c))
        case 4..<5    : return .init(red: value(x), green: value(0), blue: value(c))
        case 5..<6    : return .init(red: value(c), green: value(0), blue: value(x))
        default       : return .init(red: 0, green: 0, blue: 0)
        }
    }
    
}

extension HSB.Container: InitializableByCMYKContainer, CMYKProvider {
    
    public init(from container: CMYK.Container) {
        self = container.hsb
    }
    
    /// Returns cmyk container, equivalent to the current hsb one.
    public var cmyk: CMYK.Container { rgb.cmyk }
    
    /// Returns cmyk container, equivalent to the current hsb one.
    public func cmyk(key: ColorComponent) -> CMYK.Container { rgb.cmyk(key: key) }
    
}
