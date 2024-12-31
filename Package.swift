// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "SwiftJiraMockServer",
    platforms: [
        .macOS(.v12)
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor", from: "4.0.0")
    ],
    targets: [
        .target(
            name: "MockJiraServer",
            dependencies: [
                .product(name: "Vapor", package: "vapor")
            ]
        ),
        .executableTarget(
            name: "Run",
            dependencies: ["MockJiraServer"] // Ensure this dependency is present
        )
    ]
)

