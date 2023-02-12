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
        .package(path: "Authentication"),
        .package(path: "Settings"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "9.0.0")
    ],
    targets: [
        .target(
            name: "Dashboard",
            dependencies: [
                "Authentication",
                "Settings",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ]),
        .testTarget(
            name: "DashboardTests",
            dependencies: ["Dashboard"]),
    ]
)
