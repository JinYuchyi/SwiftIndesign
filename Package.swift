// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftIndesign",
    platforms: [
            .macOS(.v13)
        ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftIndesign",
            targets: ["SwiftIndesign"]),
    ], 
    dependencies: [
        .package(url: "https://github.com/weichsel/ZIPFoundation.git", .upToNextMajor(from: "0.9.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SwiftIndesign",
            dependencies: ["ZIPFoundation"]
        ),
        .testTarget(
            name: "SwiftIndesignTests",
            dependencies: ["SwiftIndesign"]
//            sources: ["SwiftIndesign/Sources/Script/AppleScriptUtils.swift"]

        ),
    ]
)
