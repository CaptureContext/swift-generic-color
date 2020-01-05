//
//  RGB.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension RGB.Container: Codable {}

public enum RGB: ColorSpace {
    
    public struct Container: Equatable {
        public var red: ColorComponent
        public var green: ColorComponent
        public var blue: ColorComponent
    }
    
}

extension RGB.Container {

    func hex(uppercase: Bool = false, hashTagPrefix: Bool = false) -> String {
        hashTagPrefix ? "#" : "" +
        .init(Int(red.byteValue), radix: 16, uppercase: uppercase) +
        .init(Int(green.byteValue), radix: 16, uppercase: uppercase) +
        .init(Int(blue.byteValue), radix: 16, uppercase: uppercase)
    }
    
    public func with(red value: ColorComponent) -> Self {
        .init(red: value, green: green, blue: blue)
    }
    
    public func with(green value: ColorComponent) -> Self {
        .init(red: red, green: value, blue: blue)
    }
    
    public func with(blue value: ColorComponent) -> Self {
        .init(red: red, green: green, blue: value)
    }
    
}
