// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Dashboard",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Dashboard",
            targets: ["Dashboard"]),
    ],
    dependencies: [
        .package(path: "Networking"),
        .package(path: "Settings")
    ],
    targets: [
        .target(
            name: "Dashboard",
            dependencies: [
                "Networking",
                "Settings"
            ]),
        .testTarget(
            name: "DashboardTests",
            dependencies: ["Dashboard"]),
    ]
)
