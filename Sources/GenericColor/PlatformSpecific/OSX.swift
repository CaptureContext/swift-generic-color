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
    
    public var generic: Color<RGB> {
        .init(red: .raw(redComponent),
              green: .raw(greenComponent),
              blue: .raw(blueComponent),
              alpha: .raw(alphaComponent))
    }
    
    public convenience init<Space>(_ genericColor: Color<Space>)
    where Space.Container: RGBProvider {
        let color: Color<RGB> = genericColor.map(\.rgb)
        self.init(red: CGFloat(color.red.doubleValue),
                  green: CGFloat(color.green.doubleValue),
                  blue: CGFloat(color.blue.doubleValue),
                  alpha: CGFloat(color.alpha.doubleValue))
    }
    
}

extension Color where Space.Container: RGBProvider {
    public var cocoaColor: NSColor { .init(self) }
}

#endif
