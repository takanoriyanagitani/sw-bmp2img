// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "BitmapToPng",
  dependencies: [
    .package(path: "../.."),
    .package(url: "https://github.com/realm/SwiftLint", from: "0.58.2"),
  ],
  targets: [
    .executableTarget(
      name: "BitmapToPng",
      dependencies: [
        .product(name: "BitmapToImage", package: "sw-bmp2img")
      ]
    )
  ]
)
