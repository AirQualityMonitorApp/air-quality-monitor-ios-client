// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "SessionManager",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "SessionManager",
            targets: ["SessionManager"]),
    ],
    dependencies: [
        .package(path: "Models"),
        .package(path: "Networking"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "9.0.0")
    ],
    targets: [
        .target(
            name: "SessionManager",
            dependencies: [
                "Models",
                "Networking",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
            ]),
        .testTarget(
            name: "SessionManagerTests",
            dependencies: ["SessionManager"]),
    ]
)
