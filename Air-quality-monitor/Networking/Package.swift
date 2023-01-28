// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(
            name: "Networking",
            targets: ["Networking"]),
    ],
    dependencies: [
        .package(path: "Models")
    ],
    targets: [
        .target(
            name: "Networking",
            dependencies: ["Models"]),
        .testTarget(
            name: "NetworkingTests",
            dependencies: ["Networking"]),
    ]
)
