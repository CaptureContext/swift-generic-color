//
//  SwiftUI.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

#if (os(iOS) || os(OSX)) && canImport(SwiftUI)
import SwiftUI

@available(OSX 10.15, iOS 13, *)
extension SwiftUI.Color {
    
    public init<Space>(_ genericColor: Color<Space>)
    where Space.Container: RGBProvider {
        self.init(.init(genericColor))
    }
    
// TODO: Refactor (That piece of code causes ambiguity)
//    public init<Space>(_ genericColor: Color<Space>)
//    where Space.Container: HSBProvider {
//        self.init(.init(genericColor))
//    }
    
}

extension Color where Space.Container: RGBProvider {
    public var cgColor: CGColor { cocoaColor.cgColor }

    @available(OSX 10.15, iOS 13, *)
    public var color: SwiftUI.Color { .init(self) }
}

#endif
