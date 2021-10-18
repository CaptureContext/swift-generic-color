// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "swift-generic-color",
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
