// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "GenericColor",
    products: [
        .library(
            name: "GenericColor",
            targets: ["GenericColor"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(name: "GenericColor"),
        .testTarget(
            name: "GenericColorTests",
            dependencies: [
                .target(name: "GenericColor")
            ]
        ),
    ]
)
