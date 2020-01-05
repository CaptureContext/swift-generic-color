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
    
    public static func raw(_ value: CGFloat) -> Self { .init(value: Double(value)) }
    public static func byte(_ value: CGFloat) -> Self { .byte(Double(value)) }
    
}

extension UIColor {
    
    public var generic: Color<RGB> {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 1)
        self.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        return .init(red: .raw(red), green: .raw(green), blue: .raw(blue), alpha: .raw(alpha))
    }
    
    public convenience init(_ genericColor: Color<RGB>) {
        self.init(red: CGFloat(genericColor.red.value),
                  green: CGFloat(genericColor.green.value),
                  blue: CGFloat(genericColor.blue.value),
                  alpha: CGFloat(genericColor.alpha.value))
    }
    
}

#endif
