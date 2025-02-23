// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Services",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: PackageProduct.allCases.map(\.description),
    targets: InternalTarget.allCases.map(\.target)
)

// MARK: PackageProduct

fileprivate enum PackageProduct: CaseIterable {
    case services

    var name: String {
        switch self {
        case .services: "Services"
        }
    }

    var targets: [InternalTarget] {
        switch self {
        case .services:
            InternalTarget.allCases
        }
    }

    var description: PackageDescription.Product {
        switch self {
        case .services:
            .library(
                name: self.name,
                targets: self.targets.map(\.title)
            )
        }
    }
}

// MARK: InternalTarget

fileprivate enum InternalTarget: CaseIterable {
    case audioService
    case fileService
    case speechService

    var title: String {
        switch self {
        case .audioService: "AudioService"
        case .fileService: "FileService"
        case .speechService: "SpeechService"
        }
    }

    var resources: [Resource]? {
        switch self {
        case .audioService:
            [
                .process("Resources")
            ]
        default: nil
        }
    }

    var target: Target {
        .target(
            name: self.title,
            dependencies: [],
            resources: self.resources
        )
    }
}
