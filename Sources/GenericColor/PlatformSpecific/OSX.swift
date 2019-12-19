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
    
    public static func raw(_ value: CGFloat) -> Self { .init(value: Double(value)) }
    public static func byte(_ value: CGFloat) -> Self { .byte(Double(value)) }
    
}

extension NSColor {
    
    public var generic: Color<RGB> {
        .init(red: .raw(redComponent),
              green: .raw(greenComponent),
              blue: .raw(blueComponent),
              alpha: .raw(alphaComponent))
    }
    
    public convenience init(_ genericColor: Color<RGB>) {
        self.init(red: CGFloat(genericColor.red),
                  green: CGFloat(genericColor.green),
                  blue: CGFloat(genericColor.blue),
                  alpha: CGFloat(genericColor.alpha))
    }
    
}

#endif
