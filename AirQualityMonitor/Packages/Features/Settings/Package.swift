// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Settings",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Settings",
            targets: ["Settings"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Settings",
            dependencies: [
            ]),
        .testTarget(
            name: "SettingsTests",
            dependencies: ["Settings"]),
    ]
)
