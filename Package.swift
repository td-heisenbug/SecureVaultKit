// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "SecureVaultKit",
    platforms: [
        .iOS(.v13), .watchOS(.v6), .macOS(.v10_15)
    ],
    products: [
        .library(name: "SecureVaultKit", targets: ["SecureVaultKit"]),
    ],
    targets: [
        .target(
            name: "SecureVaultKit",
            dependencies: []
        ),
        .testTarget(
            name: "SecureVaultKitTests",
            dependencies: ["SecureVaultKit"]
        ),
    ]
)
