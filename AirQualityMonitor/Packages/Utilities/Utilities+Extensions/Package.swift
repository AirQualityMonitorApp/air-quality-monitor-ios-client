// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Utilities+Extensions",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Utilities+Extensions",
            targets: ["Utilities+Extensions"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Utilities+Extensions",
            dependencies: []),
        .testTarget(
            name: "Utilities+ExtensionsTests",
            dependencies: ["Utilities+Extensions"]),
    ]
)
