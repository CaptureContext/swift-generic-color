//
//  CMYK+Conversions.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension CMYK.Container: InitializableByCMYKContainer, CMYKProvider {

    public init(from container: Self) {
        self = container
    }
    
    public var cmyk: CMYK.Container { self }
    
}

extension CMYK.Container: InitializableByRGBContainer, RGBProvider {
    
    public init(from container: RGB.Container) {
        self = container.cmyk
    }
    
    /// Returns rgb container, equivalent to the current cmyk one.
    ///
    /// https://www.rapidtables.com/convert/color/cmyk-to-rgb.html
    public var rgb: RGB.Container {
        let r = (.max - cyan) * (.max - cmyk.key)
        let g = (.max - cmyk.magenta) * (.max - cmyk.key)
        let b = (.max - cmyk.yellow) * (.max - cmyk.key)
        return RGB.Container(red: r, green: g, blue: b)
    }
    
}

extension CMYK.Container: InitializableByHSBContainer, HSBProvider {
    
    public init(from container: HSB.Container) {
        self = container.cmyk
    }
    
    /// Returns hsb container, equivalent to the current cmyk one.
    public var hsb: HSB.Container { rgb.hsb }
    
}
