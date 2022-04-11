// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HarfBuzz",
    products: [
        .library(
            name: "HarfBuzz",
            targets: ["HarfBuzz"]),
    ],
    dependencies: [
        .package(url: "https://github.com/rhx/gir2swift.git",    branch: "development"),
        .package(url: "https://github.com/rhx/SwiftGObject.git", branch: "development")
    ],
    targets: [
        .systemLibrary(
            name: "CHarfBuzz",
            pkgConfig: "harfbuzz-gobject",
            providers: [
                .brew(["harfbuzz", "glib", "glib-networking", "gobject-introspection"]),
                .apt(["libharfbuzz-dev", "libglib2.0-dev", "glib-networking", "gobject-introspection", "libgirepository1.0-dev"])
            ]),
        .target(
            name: "HarfBuzz",
            dependencies: [
                "CHarfBuzz",
                .product(name: "GLibObject", package: "SwiftGObject"),
                .product(name: "gir2swift", package: "gir2swift"),
            ],
            swiftSettings: [
                .unsafeFlags(["-suppress-warnings"], .when(configuration: .release)),
                .unsafeFlags(["-suppress-warnings", "-Xfrontend", "-serialize-debugging-options"], .when(configuration: .debug)),
            ],
            plugins: [
                .plugin(name: "gir2swift-plugin", package: "gir2swift")
            ]
        ),
        .testTarget(
            name: "HarfBuzzTests",
            dependencies: ["HarfBuzz"]),
    ]
)
