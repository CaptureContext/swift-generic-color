//
//  Color+Mapping.swift
//  GenericColor
//
//  Created by Maxim Krouk on 2/17/20.
//

extension Color {
  public func map<T: ColorSpace>(
    _ transform: (Space.Container) -> T.Container
  ) -> Color<T> {
    .init(transform(container), alpha: alpha)
  }
  
  public func flatMap<T: ColorSpace>(
    _ transform: (Color) -> Color<T>
  ) -> Color<T> {
    transform(self)
  }
}

extension Color where Space == RGB {
  public func convert<T: ColorSpace>(
    to space: T.Type = T.self
  ) -> Color<T>
  where T.Container: InitializableByRGBContainer {
    .init(.init(from: container), alpha: alpha)
  }
}

extension Color where Space == HSB {
  public func convert<T: ColorSpace>(
    to space: T.Type = T.self
  ) -> Color<T>
  where T.Container: InitializableByHSBContainer {
    .init(.init(from: container), alpha: alpha)
  }
}

extension Color where Space == CMYK {
  public func convert<T: ColorSpace>(
    to space: T.Type = T.self
  ) -> Color<T>
  where T.Container: InitializableByCMYKContainer {
    .init(.init(from: container), alpha: alpha)
  }
}
