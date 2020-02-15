//
//  ColorComponent.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

public struct ColorComponent: Equatable, Comparable, Codable, AdditiveArithmetic {
    
    public let value: Double
    public var byteValue: Double { value * 255 }
    
    /// Constructs a new color component
    ///
    /// - Parameter value: The raw value of the color component.
    /// Can take values from 0 to 1
    /// Is set to zero if the passed value was less then zero
    /// is set to one if the passed value was higher then one
    public init(value: Double = 0) {
        self.value = min(max(value, 0), 1)
    }
    
    /// An alternative to init for Int type
    public static func raw(_ value: Int) -> Self { .init(value: Double(value)) }
    
    /// An alternative to init for Float type
    public static func raw(_ value: Float) -> Self { .init(value: Double(value)) }
    
    /// An alternative to init
    public static func raw(_ value: Double) -> Self { .init(value: value) }
    
    /// Computes the value from byte representation (0 is 0, 255 is 1)
    public static func byte(_ value: Int) -> Self { .byte(Double(value)) }
    
    /// Computes the value from byte representation (0 is 0, 255 is 1)
    public static func byte(_ value: UInt8) -> Self { .byte(Double(value)) }
    
    /// Computes the value from byte representation (0 is 0, 255 is 1)
    public static func byte(_ value: Double) -> Self { .raw(value / 255) }
    
    public static func /(lhs: Self, rhs: Self) -> Self {
        .raw(lhs.value / rhs.value)
    }
    
    public static func *(lhs: Self, rhs: Self) -> Self {
        .raw(lhs.value * rhs.value)
    }
    
    public static func +(lhs: Self, rhs: Self) -> Self {
        .raw(lhs.value + rhs.value)
    }
    
    public static func -(lhs: Self, rhs: Self) -> Self {
        .raw(lhs.value - rhs.value)
    }
    
    public static func <(lhs: Self, rhs: Self) -> Bool {
        lhs.value < rhs.value
    }
    
    public static func +=(lhs: inout ColorComponent, rhs: ColorComponent) {
        lhs = lhs + rhs
    }
    
    public static func -=(lhs: inout ColorComponent, rhs: ColorComponent) {
        lhs = lhs - rhs
    }
    
}

extension ColorComponent: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self.init(value: Double(value))
    }
    
    public init(floatLiteral value: Double) {
        self.init(value: value)
    }
    
}
