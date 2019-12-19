//
//  ColorComponent.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

public struct ColorComponent: Equatable, Comparable, Codable {
    
    public var value: Double
    
    public init(value: Double) {
        self.value = value
    }
    
    public static func raw(_ value: Int) -> Self { .init(value: Double(value)) }
    public static func raw(_ value: Double) -> Self { .init(value: value) }
    public static func byte(_ value: Int) -> Self { .byte(Double(value)) }
    public static func byte(_ value: UInt8) -> Self { .byte(Double(value)) }
    
    public static func byte(_ value: Double) -> Self {
        .raw(min(255, max(0, value)) / 255)
    }
    
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
    
}

extension ColorComponent: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self.init(value: Double(value))
    }
    
    public init(floatLiteral value: Double) {
        self.init(value: value)
    }
    
}
