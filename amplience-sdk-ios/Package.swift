// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "AmplienceDelivery",

    platforms: [
        .iOS(.v13)
    ],

    products: [
        .library(
            name: "amplience-sdk-ios",
            targets: ["amplience-sdk-ios"]),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "amplience-sdk-ios",
            dependencies: []),
    ]
)
