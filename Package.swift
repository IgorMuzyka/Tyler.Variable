// swift-tools-version:4.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tyler.Variable",
    products: [
        .library(name: "Tyler.Variable", targets: ["Variable"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "Variable", dependencies: []),
    ]
)
