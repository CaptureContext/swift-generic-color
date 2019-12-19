//
//  ColorSpace.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

public struct ColorSpaceDecodingError<Space: ColorSpace>: Error {
    public var colorSpace: Space.Type
    public var key: CodingKey
    
    init(key: CodingKey) {
        self.colorSpace = Space.self
        self.key = key
    }
    
    public var localizedDescription: String {
        "Could not decode '\(colorSpace.name)' color space with '\(key.stringValue)' key."
    }
}

public protocol ColorSpace: StaticallyNamedType {
    associatedtype Container: Equatable
}
