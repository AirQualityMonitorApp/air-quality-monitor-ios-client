// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Models",
    products: [
        .library(
            name: "Models",
            targets: ["Models"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Models",
            dependencies: []),
        .testTarget(
            name: "ModelsTests",
            dependencies: ["Models"]),
    ]
)
