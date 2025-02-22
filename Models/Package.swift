// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Models",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: PackageProduct.allCases.map(\.description),
    targets: [
        InternalTarget.allCases.map(\.target),
        InternalTestTarget.allCases.map(\.target),
    ].flatMap { $0 }
)

// MARK: PackageProduct

fileprivate enum PackageProduct: CaseIterable {
    case models

    var name: String {
        switch self {
        case .models: "Models"
        }
    }

    var targets: [InternalTarget] {
        switch self {
        case .models:
            InternalTarget.allCases
        }
    }

    var description: PackageDescription.Product {
        switch self {
        case .models:
            .library(
                name: self.name,
                targets: self.targets.map(\.title)
            )
        }
    }
}

// MARK: InternalTarget

fileprivate enum InternalTarget: CaseIterable {
    case enumerations
    case extensions
    case models
    case protocols

    var title: String {
        switch self {
        case .enumerations: return "Enumerations"
        case .extensions: return "Extensions"
        case .models: return "Models"
        case .protocols: return "Protocols"
        }
    }

    var targetDependency: Target.Dependency {
        .target(name: title)
    }

    var dependencies: [Target.Dependency] {
        switch self {
        case .enumerations:
            [
                InternalTarget.protocols.targetDependency
            ]
        case .extensions:
            [
                InternalTarget.models.targetDependency
            ]
        case .models:
            [
                InternalTarget.enumerations.targetDependency
            ]
        default: []
        }
    }

    var target: Target {
        .target(
            name: self.title,
            dependencies: self.dependencies
        )
    }
}

// MARK: InternalTestTarget

fileprivate enum InternalTestTarget: CaseIterable {
    case extensions

    var title: String {
        switch self {
        case .extensions: "ExtensionsTests"
        }
    }

    var dependencies: [Target.Dependency] {
        switch self {
        case .extensions: [InternalTarget.extensions.targetDependency]
        }
    }

    var target: Target {
        .testTarget(
            name: self.title,
            dependencies: self.dependencies
        )
    }
}
