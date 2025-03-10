// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "BitmapToImage",
  products: [
    .library(name: "BitmapToImage", targets: ["BitmapToImage"]),
    .library(name: "FpUtil", targets: ["FpUtil"]),
  ],
  dependencies: [
    .package(url: "https://github.com/realm/SwiftLint", from: "0.58.2"),
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.4.3"),
  ],
  targets: [
    .target(name: "FpUtil"),
    .target(
      name: "BitmapToImage",
      dependencies: [
        "FpUtil"
      ]
    ),
    .testTarget(
      name: "BitmapToImageTests",
      dependencies: ["BitmapToImage"]
    ),
  ]
)
