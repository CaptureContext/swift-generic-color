//
//  HSB.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

extension HSB.Container: Codable {}

public enum HSB: ColorSpace {
    
    public struct Container: Equatable, KeyPathBuildable {
        public var hue: ColorComponent
        public var saturation: ColorComponent
        public var brightness: ColorComponent
    }
    
}

extension HSB.Container {
    
    public func with(hue value: ColorComponent) -> Self {
        .init(hue: value, saturation: saturation, brightness: brightness)
    }
    
    public func with(saturation value: ColorComponent) -> Self {
        .init(hue: hue, saturation: value, brightness: brightness)
    }
    
    public func with(brightness value: ColorComponent) -> Self {
        .init(hue: hue, saturation: saturation, brightness: value)
    }
    
}
