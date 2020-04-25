//
//  OSX.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

#if os(OSX)
import AppKit

extension ColorComponent {
    
    public static func raw(_ value: CGFloat) -> Self { .raw(Double(value)) }
    public static func byte(_ value: CGFloat) -> Self { .byte(Double(value)) }
    
}

extension NSColor {
    
    /// An alias for `genericRGB`
    public var generic: Color<RGB> { genericRGB }
    
    public var genericRGB: Color<RGB> {
        .init(
            red: .raw(redComponent),
            green: .raw(greenComponent),
            blue: .raw(blueComponent),
            alpha: .raw(alphaComponent)
        )
    }
    
    public var genericHSB: Color<HSB> {
        .init(
            hue: .raw(hueComponent),
            saturation: .raw(saturationComponent),
            brightness: .raw(brightnessComponent),
            alpha: .raw(alphaComponent)
        )
    }
    
    public convenience init<Space>(_ genericColor: Color<Space>)
    where Space.Container: RGBProvider {
        let color: Color<RGB> = genericColor.map(\.rgb)
        self.init(red: CGFloat(color.red.doubleValue),
                  green: CGFloat(color.green.doubleValue),
                  blue: CGFloat(color.blue.doubleValue),
                  alpha: CGFloat(color.alpha.doubleValue))
    }
    
    public convenience init<Space>(_ genericColor: Color<Space>)
    where Space.Container: HSBProvider {
        let color: Color<HSB> = genericColor.map(\.hsb)
        self.init(
            hue: CGFloat(color.hue.doubleValue),
            saturation: CGFloat(color.saturation.doubleValue),
            brightness: CGFloat(color.brightness.doubleValue),
            alpha: CGFloat(color.alpha.doubleValue)
        )
    }
    
}

extension Color where Space.Container: RGBProvider {
    public var cocoaColor: NSColor { .init(self) }
}

#endif
