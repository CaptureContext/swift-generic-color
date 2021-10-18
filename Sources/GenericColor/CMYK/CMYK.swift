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
  public func with(
    cyan: ColorComponent? = nil,
    magenta: ColorComponent? = nil,
    yellow: ColorComponent? = nil,
    key: ColorComponent? = nil
  ) -> Self {
    .init(
      cyan: cyan ?? self.cyan,
      magenta: magenta ?? self.magenta,
      yellow: yellow ?? self.yellow,
      key: key ?? self.key
    )
  }
}
