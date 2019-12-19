//
//  CMYK.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension CMYK.Container: Codable {}

public enum CMYK: ColorSpace {
    
    private enum Keys: String, CodingKey { case cmyk }
    
    public struct Container: Equatable {
        public let cyan: ColorComponent
        public let magenta: ColorComponent
        public let yellow: ColorComponent
        public let key: ColorComponent
    }
    
    public static func initialize(using decoder: Decoder) throws -> Self.Type {
        guard try decoder.container(keyedBy: Keys.self).contains(.cmyk)
        else { throw ColorSpaceDecodingError<CMYK>(key: Keys.cmyk) }
        return CMYK.self
    }
    
}

extension CMYK.Container {
    
    public func with(cyan value: ColorComponent) -> Self {
        .init(cyan: cyan, magenta: magenta, yellow: yellow, key: key)
    }
    
    public func with(magenta value: ColorComponent) -> Self {
        .init(cyan: cyan, magenta: value, yellow: yellow, key: key)
    }
    
    public func with(yellow value: ColorComponent) -> Self {
        .init(cyan: cyan, magenta: magenta, yellow: value, key: key)
    }
    
    public func with(key value: ColorComponent) -> Self {
        .init(cyan: cyan, magenta: magenta, yellow: yellow, key: value)
    }
    
}
