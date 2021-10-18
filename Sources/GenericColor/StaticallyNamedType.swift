//
//  StaticallyNamedType.swift
//  GenericColor
//
//  Created by Maxim Krouk on 9/1/19.
//  Copyright © 2019 MakeupStudio. All rights reserved.
//

public protocol StaticallyNamedType {
  static var name: String { get }
  static var fullName: String { get }
}

extension StaticallyNamedType {
  @inlinable
  public static var name: String { String(describing: self) }
  
  @inlinable
  public static var fullName: String { String(reflecting: self) }
}
