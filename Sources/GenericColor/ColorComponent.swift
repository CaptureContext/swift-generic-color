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
    
    public static var max: Self { .init(value: _max) }
    public static var min: Self { .init(value: _min) }
    
    @inlinable
    public static func ==(lhs: Self, rhs: Self) -> Bool { lhs.value == rhs.value }
    
    // MARK: - Values
    
    /// Value that matters
    ///
    /// Rounded to 9 decimal places for get, but set is exact
    public var value: Decimal {
        get { _value.rounded(9, .plain) }
        set { _value = newValue }
    }
    
    /// An alias for `exactValue`
    @inlinable
    public var decimalValue: Decimal {
        get { exactValue }
        set { exactValue = newValue }
    }
    
    /// An alias for `exactByteValue`
    @inlinable
    public var decimalByteValue: Decimal {
        get { exactByteValue }
        set { exactByteValue = newValue }
    }
    
    /// Use this value for exact calculations
    ///
    /// Raw value of the ColorComponent
    public var exactValue: Decimal {
        get { _value }
        set { self = .raw(newValue) }
    }
    
    /// Use this value for exact calculations
    ///
    /// Raw value of the ColorComponent, but
    /// - Multiplied by 255 on get
    /// - Divided by 255 on set
    /// - value(0...1) == byte(0...255)
    @inlinable
    public var exactByteValue: Decimal {
        get { exactValue * 255 }
        set { self = .byte(newValue) }
    }
    
    /// Use this value for exact calculations
    ///
    /// Raw value of the ColorComponent, but
    /// - Multiplied by 360 on get
    /// - Divided by 360 on set
    /// - value(0...1) == byte(0...360)
    @inlinable
    public var exactDegValue: Decimal {
        get { exactValue * 360 }
        set { self = .deg(newValue) }
    }
    
    /// Convenience double value getter
    ///
    /// Should not be used for exact calculations,
    /// consider using exactValue for those
    public var doubleValue: Double {
        get { exactValue.nsDecimal.doubleValue }
        set { self = .raw(newValue) }
    }
    
    /// Convenience double value getter
    ///
    /// Should not be used for exact calculations,
    /// consider using exactValue for those
    ///
    /// - Multiplied by 255 on get
    /// - Divided by 255 on set
    /// - value(0...1) == byte(0...255)
    public var doubleByteValue: Double {
        get { exactByteValue.nsDecimal.doubleValue }
        set { self = .byte(newValue) }
    }
    
    /// Convenience double value getter
    ///
    /// Should not be used for exact calculations,
    /// consider using exactValue for those
    ///
    /// - Multiplied by 360 on get
    /// - Divided by 360 on set
    /// - value(0...1) == byte(0...360)
    public var doubleDegValue: Double {
        get { exactDegValue.nsDecimal.doubleValue }
        set { self = .deg(newValue) }
    }
    
    /// Convenience double value getter
    ///
    /// Should not be used for exact calculations,
    /// consider using exactValue for those
    public var floatValue: Float {
        get { exactValue.nsDecimal.floatValue }
        set { self = .raw(newValue) }
    }
    
    /// Convenience double value getter
    ///
    /// Should not be used for exact calculations,
    /// consider using exactValue for those
    ///
    /// - Multiplied by 255 on get
    /// - Divided by 255 on set
    /// - value(0...1) == byte(0...255)
    public var floatByteValue: Float {
        get { exactByteValue.nsDecimal.floatValue }
        set { self = .byte(newValue) }
    }
    
    /// Convenience double value getter
    ///
    /// Should not be used for exact calculations,
    /// consider using exactValue for those
    ///
    /// - Multiplied by 360 on get
    /// - Divided by 360 on set
    /// - value(0...1) == byte(0...360)
    public var floatDegValue: Float {
        get { exactDegValue.nsDecimal.floatValue }
        set { self = .deg(newValue) }
    }
    
    /// Convenience double value getter
    ///
    /// Should not be used for exact calculations,
    /// consider using exactValue for those
    ///
    /// - Multiplied by 255 on get
    /// - Divided by 255 on set
    /// - value(0...1) == byte(0...255)
    public var byteValue: Int {
        get { exactByteValue.rounded(0, .plain).nsDecimal.intValue }
        set { self = .byte(newValue) }
    }
    
    /// Value in degrees
    ///
    /// value(0...1) == deg(0...360)
    public var degValue: Int {
        get { exactDegValue.rounded(0, .plain).nsDecimal.intValue }
        set { self = .deg(newValue) }
    }
    
    public func hex(uppercase: Bool = false) -> String {
        let value = String(byteValue, radix: 16, uppercase: uppercase)
        return value.count == 1 ? "0".appending(value) : value
    }
    
    // MARK: - Init
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
    
    @inlinable
    public static func raw(_ value: Float) -> Self { .raw(Double(value)) }
    
    @inlinable
    public static func raw(_ value: Double) -> Self { .raw(Decimal(value)) }
    
    @inlinable
    public static func raw(_ value: Int) -> Self { .raw(Decimal(value)) }
    
    @inlinable
    public static func raw(_ value: UInt8) -> Self { .raw(Decimal(value)) }
    
    @inlinable
    public static func raw(_ value: Decimal) -> Self { .init(value: value) }
    
    // MARK: Byte
    
    /// Computes the value from byte representation
    ///
    /// value(0...1) == byte(0...255)
    @inlinable
    public static func byte(_ value: Float) -> Self { .byte(Double(value)) }
    
    /// Computes the value from byte representation
    ///
    /// value(0...1) == byte(0...255)
    @inlinable
    public static func byte(_ value: Double) -> Self { .byte(Decimal(value)) }
    
    /// Computes the value from byte representation
    ///
    /// value(0...1) == byte(0...255)
    @inlinable
    public static func byte(_ value: Int) -> Self { .byte(Decimal(value)) }
    
    /// Computes the value from byte representation
    ///
    /// value(0...1) == byte(0...255)
    @inlinable
    public static func byte(_ value: UInt8) -> Self { .byte(Decimal(value)) }
    
    /// Computes the value from byte representation
    ///
    /// value(0...1) == byte(0...255)
    @inlinable
    public static func byte(_ value: Decimal) -> Self { .init(value: value / 255) }
    
    // MARK: Deg
    
    /// Computes the value from deg representation
    ///
    /// value(0...1) == deg(0...360)
    @inlinable
    public static func deg(_ value: Float) -> Self { .deg(Double(value)) }
    
    /// Computes the value from deg representation
    ///
    /// value(0...1) == deg(0...360)
    @inlinable
    public static func deg(_ value: Double) -> Self { .deg(Decimal(value)) }
    
    /// Computes the value from deg representation
    ///
    /// value(0...1) == deg(0...360)
    @inlinable
    public static func deg(_ value: Int) -> Self { .deg(Decimal(value)) }
    
    /// Computes the value from deg representation
    ///
    /// value(0...1) == deg(0...360)
    @inlinable
    public static func deg(_ value: UInt8) -> Self { .deg(Decimal(value)) }
    
    /// Computes the value from deg representation
    ///
    /// value(0...1) == deg(0...360)
    @inlinable
    public static func deg(_ value: Decimal) -> Self { .init(value: value / 360) }
    
    // MARK: - Functions
    
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
    
    @inlinable
    public static func +=(lhs: inout ColorComponent, rhs: ColorComponent) {
        lhs = lhs + rhs
    }
    
    @inlinable
    public static func -=(lhs: inout ColorComponent, rhs: ColorComponent) {
        lhs = lhs - rhs
    }
    
}

extension ColorComponent: ExpressibleByFloatLiteral, ExpressibleByIntegerLiteral {
    
    @inlinable
    public init(integerLiteral value: Double) {
        self.init(floatLiteral: value)
    }
    
    @inlinable
    public init(floatLiteral value: Double) {
        self = .raw(value)
    }
    
}
