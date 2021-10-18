//
//  ConvertionInitProtocols.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

// MARK: - RGB
public protocol InitializableByRGBContainer {
  init(from container: RGB.Container)
}

public protocol RGBProvider {
  var rgb: RGB.Container { get }
}

// MARK: - HSB
public protocol InitializableByHSBContainer {
  init(from container: HSB.Container)
}

public protocol HSBProvider {
  var hsb: HSB.Container { get }
}

// MARK: - CMYK
public protocol InitializableByCMYKContainer {
  init(from container: CMYK.Container)
}

public protocol CMYKProvider {
  var cmyk: CMYK.Container { get }
}
