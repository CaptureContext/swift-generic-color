// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GenericColor",
    products: [
        .library(
            name: "GenericColor",
            targets: ["GenericColor"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GenericColor",
            dependencies: []),
        .testTarget(
            name: "GenericColorTests",
            dependencies: ["GenericColor"]),
    ]
)
