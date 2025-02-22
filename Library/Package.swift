// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Library",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: PackageProduct.allCases.map(\.description),
    dependencies: SwiftPackage.allCases.map(\.packageDependency),
    targets: [
        InternalTarget.allCases.map(\.target)
    ].flatMap { $0 }
)

// MARK: PackageProduct

fileprivate enum PackageProduct: CaseIterable {
    case scrumdinger

    var name: String {
        switch self {
        case .scrumdinger: "Scrumdinger"
        }
    }

    var targets: [InternalTarget] {
        switch self {
        case .scrumdinger:
            InternalTarget.allCases
        }
    }

    var description: PackageDescription.Product {
        switch self {
        case .scrumdinger:
            .library(
                name: self.name,
                targets: self.targets.map(\.title)
            )
        }
    }
}

// MARK: InternalTarget

fileprivate enum InternalTarget: CaseIterable {
    case configuration
    case resources
    case scrum

    var title: String {
        switch self {
        case .configuration: return "Configuration"
        case .resources: return "Resources"
        case .scrum: return "Scrum"
        }
    }

    var targetDependency: Target.Dependency {
        .target(name: title)
    }

    var dependencies: [Target.Dependency] {
        switch self {
        case .configuration:
            [
                SwiftPackage.models.targetDependency,
                SwiftPackage.services.targetDependency,
            ]
        case .resources:
            [
                SwiftPackage.models.targetDependency,
                SwiftPackage.viewComponents.targetDependency,
            ]
        case .scrum:
            [
                InternalTarget.resources.targetDependency,
                SwiftPackage.models.targetDependency,
                SwiftPackage.services.targetDependency,
                SwiftPackage.viewComponents.targetDependency,
            ]
        }
    }

    var resources: [Resource]? {
        switch self {
        case .resources:
            [
                .process("Media.xcassets")
            ]
        default: nil
        }
    }

    var target: Target {
        .target(
            name: self.title,
            dependencies: self.dependencies,
            resources: self.resources
        )
    }
}

// MARK: SwiftPackage

fileprivate enum SwiftPackage: CaseIterable {
    case models
    case services
    case viewComponents

    var packageDependency: Package.Dependency {
        switch self {
        case .models:
            .package(path: "../Models")
        case .services:
            .package(path: "../Services")
        case .viewComponents:
            .package(path: "../ViewComponents")
        }
    }

    var targetDependency: Target.Dependency {
        switch self {
        case .models:
            .product(name: "Models", package: "Models")
        case .services:
            .product(name: "Services", package: "Services")
        case .viewComponents:
            .product(name: "ViewComponents", package: "ViewComponents")
        }
    }
}
