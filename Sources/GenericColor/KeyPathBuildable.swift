//
//  KeyPathBuildable.swift
//  GenericColor
//
//  Created by Maxim Krouk on 3/26/20.
//

public protocol KeyPathBuildable {}

extension KeyPathBuildable {
    public func with<T>(_ keyPath: WritableKeyPath<Self, T>, _ value: T) -> Self {
        self.with(keyPath == value)
    }
    
    public func with(_ transform: (Self) -> Self) -> Self {
        transform(self)
    }
}

public func ==<Object, Value>(_ lhs: WritableKeyPath<Object, Value>, _ rhs: Value)
-> (Object) -> Object {
    { object in
        var output = object
        output[keyPath: lhs] = rhs
        return output
    }
}
