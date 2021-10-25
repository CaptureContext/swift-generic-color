// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "swift-generic-color",
  platforms: [
    .iOS(.v13),
    .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "GenericColor",
      targets: ["GenericColor"]
    ),
  ],
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
