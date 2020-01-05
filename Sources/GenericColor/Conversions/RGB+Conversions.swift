//
//  RGB+Conversions.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension RGB.Container: InitializableByRGBContainer, RGBProvider {
    
    public init(from container: Self) {
        self = container
    }
    
    /// Returns self
    public var rgb: RGB.Container { self }
    
}

extension RGB.Container: InitializableByHSBContainer, HSBProvider {
    
    public init(from container: HSB.Container) {
        self = container.rgb
    }
    
    /// Returns hsb container, equivalent to the current rgb one.
    ///
    /// https://www.rapidtables.com/convert/color/rgb-to-hsv.html
    public var hsb: HSB.Container {
        let rgb = (red: red.value, green: green.value, blue: blue.value)
        var (hue, saturation, brightness) = (0.0, 0.0, 0.0)
        
        let maxV = max(rgb.red, rgb.green, rgb.blue)
        let minV = min(rgb.red, rgb.green, rgb.blue)
        let delta = maxV - minV
        if delta != 0 {
            switch maxV {
            case rgb.red:   hue = (0 + (rgb.green - rgb.blue)  / delta) / 6
            case rgb.green: hue = (2 + (rgb.blue  - rgb.red)   / delta) / 6
            default:        hue = (4 + (rgb.red   - rgb.green) / delta) / 6
            }
            if hue < 0 { hue += 1 }
        }
        brightness = maxV
        saturation = brightness == 0 ? 0 : (delta / brightness)
        return HSB.Container(hue: .raw(hue), saturation: .raw(saturation), brightness: .raw(brightness))
    }
    
}

extension RGB.Container: InitializableByCMYKContainer, CMYKProvider {
    
    public init(from container: CMYK.Container) {
        self = container.rgb
    }
    
    /// Returns cmyk container, equivalent to the current rgb one.
    ///
    /// https://www.ginifab.com/feeds/pms/cmyk_to_rgb.php
    public var cmyk: CMYK.Container { cmyk(key: .raw(1 - max(red.value, green.value, blue.value))) }
    
    /// Returns cmyk container, equivalent to the current rgb one.
    ///
    /// https://www.ginifab.com/feeds/pms/cmyk_to_rgb.php
    ///
    /// - Parameter key: Default key value for `.cmyk` is `1 - max(red.value, green.value, blue.value)`.
    public func cmyk(key: ColorComponent) -> CMYK.Container {
        let rgb = (red: red.value, green: green.value, blue: blue.value)
        let d = 1 - key.value
        let c = 1 - rgb.red   / d
        let m = 1 - rgb.green / d
        let y = 1 - rgb.blue  / d
        return CMYK.Container(cyan: .raw(c), magenta: .raw(m), yellow: .raw(y), key: key)
    }
    
    
}
