//
//  CMYK.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension CMYK.Container: Codable {}

public enum CMYK: ColorSpace {
    
    public struct Container: Equatable {
        public var cyan: ColorComponent
        public var magenta: ColorComponent
        public var yellow: ColorComponent
        public var key: ColorComponent
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
