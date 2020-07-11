//
//  RGBAInitializable.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

public protocol RGBAInitializable {
    
    /// Initializes a new instance of RGBColor
    init(red: ColorComponent, green: ColorComponent, blue: ColorComponent, alpha: ColorComponent)
    
}

extension RGBAInitializable {
    
    /// Initializes a new instance from Hex
    ///
    /// Returns nil if string is not hex color convertable
    ///
    /// Examples of valid strings:
    /// - "09F"
    /// - "#09F"
    /// - "09FF"
    /// - "#09FF"
    /// - "0099FF"
    /// - "#0099FF"
    /// - "0099FFFF"
    /// - "#0099FFFF"
    /// - "09f"
    /// - "#09f"
    /// - "09ff"
    /// - "#09ff"
    /// - "0099ff"
    /// - "#0099ff"
    /// - "0099ffff"
    /// - "#0099ffff"
    /// 
    /// - Parameter value: Hex color pattern.
    public init?(hex: String) {
        guard let rgba = hex.scanHexRgba() else { return nil }
        self.init(
            red: .byte(rgba.red),
            green: .byte(rgba.green),
            blue: .byte(rgba.blue),
            alpha: .byte(rgba.alpha)
        )
    }
    
    /// Initializes a new instance from Hex
    ///
    /// Returns nil if hex value is out of (0...0xffffff) range.
    ///
    /// - Parameter value: Hex color pattern.
    public init?(rgb value: Int) {
        guard (0...0xffffff).contains(value) else { return nil }
        self.init(rgba: UInt32(value) << 8 + 0xff)
    }
    
    /// Initializes a new instance from Hex
    ///
    /// Returns nil if hex value is out of (0...0xffffffff) range.
    ///
    /// - Parameter value: Hex color pattern.
    public init?(rgba value: UInt32) {
        guard (0...0xffffffff).contains(value) else { return nil }
        self.init(
            red   : .byte(Double((value & 0xff000000) >> 24)),
            green : .byte(Double((value & 0x00ff0000) >> 16)),
            blue  : .byte(Double((value & 0x0000ff00) >> 8)),
            alpha : .byte(Double(value & 0x000000ff))
        )
    }
    
    /// Initializes a new instance from Hex
    ///
    /// Returns nil if string is not hex color convertable
    ///
    /// Examples of valid strings:
    /// - "09F"
    /// - "#09F"
    /// - "09FF"
    /// - "#09FF"
    /// - "0099FF"
    /// - "#0099FF"
    /// - "0099FFFF"
    /// - "#0099FFFF"
    /// - "09f"
    /// - "#09f"
    /// - "09ff"
    /// - "#09ff"
    /// - "0099ff"
    /// - "#0099ff"
    /// - "0099ffff"
    /// - "#0099ffff"
    ///
    /// - Parameter value: Hex color pattern.
    public static func hex(_ value: String) -> Self? { Self.init(hex: value) }
    
    /// Initializes a new instance from Hex
    ///
    /// Returns nil if hex value is out of (0...0xffffff) range.
    ///
    /// - Parameter value: Hex color pattern.
    public static func hex(rgb value: Int) -> Self? { Self.init(rgb: value) }
    
    /// Initializes a new instance from Hex
    ///
    /// Returns nil if hex value is out of (0...0xffffffff) range.
    ///
    /// - Parameter value: Hex color pattern.
    public static func hex(rgba value: Int) -> Self? { Self.init(rgba: UInt32(value)) }
    
}
