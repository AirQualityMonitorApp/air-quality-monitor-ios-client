// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Authentication",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Authentication",
            targets: ["Authentication"]),
    ],
    dependencies: [
        .package(path: "Models"),
        .package(path: "Networking"),
        .package(path: "SessionManager"),
        .package(path: "UIComponents"),
        .package(path: "Utilities+Extensions"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "9.0.0")
    ],
    targets: [
        .target(
            name: "Authentication",
            dependencies: [
                "Models",
                "Networking",
                "SessionManager",
                "UIComponents",
                "Utilities+Extensions",
                .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
        ]),
        .testTarget(
            name: "AuthenticationTests",
            dependencies: ["Authentication"]),
    ]
)
