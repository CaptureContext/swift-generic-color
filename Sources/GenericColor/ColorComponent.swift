//
//  ColorComponent.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

import Foundation

public struct ColorComponent: Equatable, Comparable, Codable, AdditiveArithmetic {
    public static var zero: ColorComponent = .init(value: 0)
    
    private static let _max: Decimal = 1
    private static let _min: Decimal = 0
    private var _value: Decimal
    private var _decimal: NSDecimalNumber { _value.nsDecimal }
    
    public static var max: Self { .init(value: _max) }
    public static var min: Self { .init(value: _min) }
    
    public static func ==(lhs: Self, rhs: Self) -> Bool {
        lhs._value.rounded(9, .plain) == rhs._value.rounded(9, .plain)
    }
    
    public var decimalValue: Decimal {
        get { _value }
        set { self = .init(value: newValue) }
    }
    
    public var decimalByteValue: Decimal {
        get { _value * 255 }
        set { self = .byte(newValue) }
    }
    
    public var doubleValue: Double {
        get { _decimal.doubleValue }
        set { self = .raw(newValue) }
    }
    
    public var byteValue: Int {
        get { decimalByteValue.rounded(0, .plain).nsDecimal.intValue }
        set { self = .byte(newValue) }
    }
    
    public func hex(uppercase: Bool = false) -> String {
        let value = String(byteValue, radix: 16, uppercase: uppercase)
        return value.count == 1
            ? "0".appending(value)
            : value
    }
    
    // MARK: Init
    /// Constructs a new color component
    ///
    /// - Parameter value: The raw value of the color component.
    /// Can take values from 0 to 1
    /// Is set to zero if the passed value was less then zero
    /// is set to one if the passed value was higher then one
    public init(value: Decimal = 0) {
        self._value = Self.validated(value)
    }
    
    private static func validated(_ value: Decimal) -> Decimal { Swift.min(Swift.max(value, _min), _max) }
    
    // MARK: Raw
    
    public static func raw(_ value: Float) -> Self { .raw(Double(value)) }
    
    public static func raw(_ value: Double) -> Self { .raw(Decimal(value)) }
    
    public static func raw(_ value: Int) -> Self { .raw(Decimal(value)) }
    
    public static func raw(_ value: UInt8) -> Self { .raw(Decimal(value)) }
    
    public static func raw(_ value: Decimal) -> Self { .init(value: value) }
    
    // MARK: Byte
    
    /// Computes the value from byte representation
    public static func byte(_ value: Float) -> Self { .byte(Double(value)) }
    
    /// Computes the value from byte representation
    public static func byte(_ value: Double) -> Self { .byte(Decimal(value)) }
    
    /// Computes the value from byte representation
    public static func byte(_ value: Int) -> Self { .byte(Decimal(value)) }
    
    /// Computes the value from byte representation
    public static func byte(_ value: UInt8) -> Self { .byte(Decimal(value)) }
    
    /// Computes the value from byte representation
    public static func byte(_ value: Decimal) -> Self { .init(value: value / 255) }
    
    // MARK: Functions
    
//    public static func ==(lhs: Self, rhs: Self) -> Bool {
//        lhs._value == rhs._value
//    }
    
    public static func ===(lhs: Self, rhs: Self) -> Bool {
        lhs._value == rhs._value
    }
    
    public static func /(lhs: Self, rhs: Self) -> Self {
        .raw(lhs._value / rhs._value)
    }
    
    public static func *(lhs: Self, rhs: Self) -> Self {
        .raw(lhs._value * rhs._value)
    }
    
    public static func +(lhs: Self, rhs: Self) -> Self {
        .raw(lhs._value + rhs._value)
    }
    
    public static func -(lhs: Self, rhs: Self) -> Self {
        .raw(lhs._value - rhs._value)
    }
    
    public static func <(lhs: Self, rhs: Self) -> Bool {
        lhs._value < rhs._value
    }
    
    public static func +=(lhs: inout ColorComponent, rhs: ColorComponent) {
        lhs = lhs + rhs
    }
    
    public static func -=(lhs: inout ColorComponent, rhs: ColorComponent) {
        lhs = lhs - rhs
    }
    
}

extension ColorComponent: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Double) {
        self = .raw(value)
    }
    
}
