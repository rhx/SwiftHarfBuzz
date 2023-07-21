# SwiftHarfBuzz

A Swift wrapper around harfbuzz-4.x that is largely auto-generated from gobject-introspection.
For up to date (auto-generated) reference documentation, see https://rhx.github.io/SwiftHarfBuzz/

![Ubuntu 20.04 build](https://github.com/rhx/SwiftHarfBuzz/workflows/Ubuntu%2020.04/badge.svg)
![Ubuntu 18.04 build](https://github.com/rhx/SwiftHarfBuzz/workflows/Ubuntu%2018.04/badge.svg)

## Prerequisites

### Swift 5.6 or higher

To build, download Swift from https://swift.org/download/ -- if you are using macOS, make sure you have the command line tools installed as well).  Test that your compiler works using `swift --version`, which should give you something like

	$ swift --version
	swift-driver version: 1.62.15 Apple Swift version 5.7.2 (swiftlang-5.7.2.135.5 clang-1400.0.29.51)
    Target: x86_64-apple-macosx12.0

on macOS, or on Linux you should get something like:

	$ swift --version
	Swift version 5.7.3 (swift-5.7.3-RELEASE)
	Target: x86_64-unknown-linux-gnu

### GLib 2.56 and HarfBuzz 4.2 or higher

These Swift wrappers have been tested with glib-2.56, 2.58, 2.60, 2.62, 2.64, 2.66, 2.68, 2.70, and 2.72, as well as HarfBuzz 4.2, 7.1, and 8.0.  They should work with higher versions, but YMMV.  Also make sure you have `gobject-introspection` and its `.gir` files installed.

#### Linux

##### Ubuntu

On Ubuntu 20.04 you can use the HarfBuzz that comes with the distribution.  Just install with the `apt` package manager:

	sudo apt update
	sudo apt install libharfbuzz-dev gir1.2-harfbuzz-0.0 gobject-introspection libgirepository1.0-dev libxml2-dev jq

##### Fedora

On Fedora 29, you can use the gtk that comes with the distribution.  Just install with the `dnf` package manager:

	sudo dnf install harfbuzz-devel glib2-devel gobject-introspection-devel libxml2-devel jq

#### macOS

On macOS, you can install HarfBuzz using HomeBrew (for setup instructions, see http://brew.sh).  Once you have a running HomeBrew installation, you can use it to install a native version of HarfBuzz:

	brew update
	brew install harfbuzz glib glib-networking gobject-introspection pkg-config jq

## Usage

Normally, you don't build this package directly (but for testing you can - see 'Building' below). Instead you need to embed SwiftHarfBuzz into your own project using the [Swift Package Manager](https://swift.org/package-manager/).  After installing the prerequisites (see 'Prerequisites' below), add `SwiftHarfBuzz` as a dependency to your `Package.swift` file, e.g.:

```Swift
// swift-tools-version:5.6

import PackageDescription

let package = Package(name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/rhx/gir2swift.git", branch: "main"),
        .package(url: "https://github.com/rhx/SwiftHarfBuzz.git",  branch: "main"),
    ],
    targets: [
        .target(name: "MyPackage",
                dependencies: [
                    .product(name: "HarfBuzz", package: "SwiftHarfBuzz")
                ]
        )
    ]
)
```

## Building

Normally, you don't build this package directly, but you embed it into your own project (see 'Usage' above).  However, you can build and test this module separately to ensure that everything works.  Make sure you have all the prerequisites installed (see above).  After that, you can simply clone this repository and build the command line executable (be patient, this will download all the required dependencies and take a while to compile) using

	git clone https://github.com/rhx/SwiftHarfBuzz.git
	cd SwiftHarfBuzz
    swift build
    swift test

### Xcode

On macOS, you can build the project using Xcode instead.  To do this, you need to open the package in the Xcode IDE:

    cd SwiftHarfBuzz
	open Package.swift

After that, use the (usual) Build and Test buttons to build/test this package.

## Documentation

You can generate documentation using the [DocC plugin](https://apple.github.io/swift-docc-plugin/documentation/swiftdoccplugin/).  To preview documentation matching your local installation, simply run

    swift package --disable-sandbox preview-documentation

then navigate to the URL shown for the local preview server.  Make sure you have JavaScript enabled in your browser.

Alternatively, you can create static documentation using [jazzy](https://github.com/realm/jazzy).
Make sure you have [sourcekitten](https://github.com/jpsim/SourceKitten) and [jazzy](https://github.com/realm/jazzy) installed, e.g. on macOS (x86_64):

	brew install ruby sourcekitten
	/usr/local/opt/ruby/bin/gem install jazzy
	./generate-jazzy.sh

## Troubleshooting

Here are some common errors you might encounter and how to fix them.

### Missing `.gir` Files

If you get an error such as

	Girs located at
	Cannot open '/GLib-2.0.gir': No such file or directory

Make sure that you have the relevant `gobject-introspection` packages installed (as per the Pre-requisites section), including their `.gir` and `.pc` files.

### Old Swift toolchain or Xcode

If, when you run `swift build`, you get a `Segmentation fault (core dumped)` or circular dependency error such as

	warning: circular dependency detected while parsing pangocairo: harfbuzz -> freetype2 -> harfbuzz
	
this probably means that your Swift toolchain is too old, particularly on Linux.
Make sure the latest toolchain is the one that is found when you run the Swift compiler (see above).

  If you get an older version, make sure that the right version of the swift compiler is found first in your `PATH`.  On macOS, use xcode-select to select and install the latest version, e.g.:

	sudo xcode-select -s /Applications/Xcode.app
	xcode-select --install
