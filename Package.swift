// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ta4swift",
    platforms: [
        .iOS(.v10),
        .macOS(.v10_12)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ta4swift",
            targets: ["ta4swift"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ta4swift",
            dependencies: [.product(name: "Logging", package: "swift-log")]),
        .testTarget(
            name: "ta4swiftTests",
            dependencies: ["ta4swift", .product(name: "Logging", package: "swift-log")],
            resources: [
                .process("Resources")
            ]),
    ]
)
