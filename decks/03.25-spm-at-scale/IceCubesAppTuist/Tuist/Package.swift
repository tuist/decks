// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "IceCubes",
    dependencies: [
        .package(path: "../Packages/Account"),
        .package(path: "../Packages/AppAccount"),
        .package(path: "../Packages/Conversations"),
        .package(path: "../Packages/DesignSystem"),
        .package(path: "../Packages/Env"),
        .package(path: "../Packages/Explore"),
        .package(path: "../Packages/Lists"),
        .package(path: "../Packages/MediaUI"),
        .package(path: "../Packages/Models"),
        .package(path: "../Packages/Network"),
        .package(path: "../Packages/Notifications"),
        .package(path: "../Packages/StatusKit"),
        .package(path: "../Packages/Timeline"),
        .package(url: "https://github.com/RevenueCat/purchases-ios", from: "4.39.0"),
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols", from: "5.2.0"),
    ]
)
