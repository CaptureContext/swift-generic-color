//
//  Color+Mapping.swift
//  GenericColor
//
//  Created by Maxim Krouk on 2/17/20.
//

extension Color {
    public func map<T: ColorSpace>(_ keyPath: KeyPath<Space.Container, T.Container>) -> Color<T> {
        .init(container[keyPath: keyPath], alpha: alpha)
    }
}

extension Color where Space == RGB {
    public func map<T: ColorSpace>(to type: T.Type = T.self) -> Color<T>
    where T.Container: InitializableByRGBContainer {
        .init(.init(from: container), alpha: alpha)
    }
}

extension Color where Space == HSB {
    public func map<T: ColorSpace>(to type: T.Type = T.self) -> Color<T>
    where T.Container: InitializableByHSBContainer {
        .init(.init(from: container), alpha: alpha)
    }
}

extension Color where Space == CMYK {
    public func map<T: ColorSpace>(to type: T.Type = T.self) -> Color<T>
    where T.Container: InitializableByCMYKContainer {
        .init(.init(from: container), alpha: alpha)
    }
}
