// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ViewComponents",
    defaultLocalization: "en",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: PackageProduct.allCases.map(\.description),
    targets: [
        InternalTarget.allCases.map(\.target)
    ].flatMap { $0 }
)

// MARK: PackageProduct

fileprivate enum PackageProduct: CaseIterable {
    case viewComponents

    var name: String {
        switch self {
        case .viewComponents: "ViewComponents"
        }
    }

    var targets: [InternalTarget] {
        switch self {
        case .viewComponents:
            InternalTarget.allCases
        }
    }

    var description: PackageDescription.Product {
        switch self {
        case .viewComponents:
            .library(
                name: self.name,
                targets: self.targets.map(\.title)
            )
        }
    }
}

// MARK: InternalTarget

fileprivate enum InternalTarget: CaseIterable {
    case viewComponents

    var title: String {
        switch self {
        case .viewComponents: return "ViewComponents"
        }
    }

    var targetDependency: Target.Dependency {
        .target(name: title)
    }

    var dependencies: [Target.Dependency] { [] }

    var target: Target {
        .target(
            name: self.title,
            dependencies: self.dependencies
        )
    }
}
