//
//  StaticallyNamedType.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

public protocol StaticallyNamedType {
    
    static var name: String { get }
    static var path: String { get }
    
}

extension StaticallyNamedType {
    
    @inlinable
    public static var type: Self.Type { Self.self }
    
    @inlinable
    public static var name: String { String(describing: type) }
    
    @inlinable
    public static var path: String { String(reflecting: type) }
    
}
