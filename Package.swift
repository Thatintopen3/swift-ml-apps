
// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftMLApp",
    platforms: [
        .macOS(.v10_15), .iOS(.v13)
    ],
    products: [
        .library(name: "SwiftMLApp", targets: ["SwiftMLApp"]),
    ],
    dependencies: [
        // Dependencies can be added here, e.g., for CoreMLTools or other ML libraries
        // .package(url: "https://github.com/apple/swift-algorithms", from: "0.0.1"),
    ],
    targets: [
        .target(
            name: "SwiftMLApp",
            dependencies: [],
            resources: [.process("MLModels")]
        ),
        .testTarget(
            name: "SwiftMLAppTests",
            dependencies: ["SwiftMLApp"]),
    ]
)
