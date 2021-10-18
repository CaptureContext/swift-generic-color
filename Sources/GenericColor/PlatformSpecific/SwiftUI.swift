//
//  SwiftUI.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

#if (os(iOS) || os(OSX))
import CoreGraphics

#if canImport(SwiftUI)
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

@available(OSX 10.15, iOS 13, *)
extension SwiftUI.Color {
  public init?(hex: String) {
    guard let color = Color<RGB>(hex: hex) else { return nil }
    self.init(color)
  }
}

@available(OSX 10.15, iOS 13, *)
extension Color where Space.Container: RGBProvider {
  public var color: SwiftUI.Color { .init(self) }
}

#endif

extension Color where Space.Container: RGBProvider {
  public var cgColor: CGColor { cocoaColor.cgColor }
}

#endif
