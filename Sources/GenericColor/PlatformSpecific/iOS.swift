//
//  iOS.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

#if os(iOS)
import UIKit

extension ColorComponent {
    
    public static func raw(_ value: CGFloat) -> Self { .raw(Double(value)) }
    public static func byte(_ value: CGFloat) -> Self { .byte(Double(value)) }
    
}

extension UIColor {
    
    /// An alias for `genericRGB`
    public var generic: Color<RGB> { genericRGB }
    
    public var genericRGB: Color<RGB> {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 1)
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return .init(red: .raw(red), green: .raw(green), blue: .raw(blue), alpha: .raw(alpha))
    }
    
    public var genericHSB: Color<HSB> {
        var (hue, saturation, brightness, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 1)
        self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        return .init(
            hue: .raw(hue),
            saturation: .raw(saturation),
            brightness: .raw(brightness),
            alpha: .raw(alpha)
        )
    }
    
    public convenience init<Space>(_ genericColor: Color<Space>)
    where Space.Container: RGBProvider {
        let color: Color<RGB> = genericColor.map(\.rgb)
        self.init(
            red: CGFloat(color.red.doubleValue),
            green: CGFloat(color.green.doubleValue),
            blue: CGFloat(color.blue.doubleValue),
            alpha: CGFloat(color.alpha.doubleValue)
        )
    }
    
// TODO: Refactor (That piece of code causes ambiguity)
//    public convenience init<Space>(_ genericColor: Color<Space>)
//    where Space.Container: HSBProvider {
//        let color: Color<HSB> = genericColor.map(\.hsb)
//        self.init(
//            hue: CGFloat(color.hue.doubleValue),
//            saturation: CGFloat(color.saturation.doubleValue),
//            brightness: CGFloat(color.brightness.doubleValue),
//            alpha: CGFloat(color.alpha.doubleValue)
//        )
//    }
    
}

extension Color where Space.Container: RGBProvider {
    public var cocoaColor: UIColor { .init(self) }
}

#endif
