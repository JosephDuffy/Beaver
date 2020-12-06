// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "Beaver",
    platforms: [
        .macOS(.v10_12),
        .iOS(.v10),
        .tvOS(.v10),
        .watchOS(.v3),
    ],
    products: [
        .library(name: "Beaver", targets: ["Beaver"])
    ],
    targets: [
        .target(name: "Beaver")
    ]
)
