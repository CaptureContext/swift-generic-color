//
//  Convertions.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension RGB.Container {
    
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
