// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StarIO10",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "StarIO10",
            targets: ["StarIO10"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "StarIO10",
            path: "StarIO10.xcframework")
    ]
)
