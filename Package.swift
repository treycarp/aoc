// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Advent of Code",
    platforms: [.macOS(.v10_14)],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .executable(name: "trey", targets: ["trey"]),
        .library(name: "AOC", targets: ["AOC"]),
        .library(name: "AOCShared", targets: ["AOCShared"]),
        .library(name: "AOC2018", targets: ["AOC2018"]),
        .library(name: "AOC2019", targets: ["AOC2019"]),
        .library(name: "AOC2020", targets: ["AOC2020"]),
        .library(name: "AOC2021", targets: ["AOC2021"]),
        .library(name: "AOC2022", targets: ["AOC2022"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "trey", dependencies: ["AOC"]),
        .target(name: "AOC", dependencies: ["AOC2018", "AOC2019", "AOC2020", "AOC2021", "AOC2022"]),
        .target(name: "AOC2018", dependencies: ["AOCShared"]),
        .target(name: "AOC2019", dependencies: ["AOCShared"]),
        .target(name: "AOC2020", dependencies: ["AOCShared"]),
        .target(name: "AOC2021", dependencies: ["AOCShared"]),
        .target(name: "AOC2022", dependencies: ["AOCShared"]),
        .target(name: "AOCShared", dependencies: []),
        
        .testTarget(name: "AOCTests", dependencies: ["AOC"]),
    ]
)
