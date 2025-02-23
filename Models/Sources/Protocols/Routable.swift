//
//  Routable.swift
//
//  Created by James Sedlacek on 2/7/25.
//

import SwiftUI

/// Routable provides a standardized way to handle navigation and view creation in SwiftUI.
///
/// This protocol combines:
/// - Hashable: For unique identification of routes
/// - View: For rendering the destination
/// - Identifiable: For collection management
///
/// Usage:
/// ```swift
/// enum AppRoute: Routable {
///     case detail(item: Item)
///     case settings
///
///     var body: some View {
///         switch self {
///         case .detail(let item):
///             DetailView(item: item)
///         case .settings:
///             SettingsView()
///         }
///     }
/// }
/// ```
public protocol Routable: Hashable, View, Identifiable {
    /// The route itself serves as its identifier
    var id: Self { get }

    /// Creates the destination view for a given route
    /// - Parameter route: The route to create a view for
    /// - Returns: The view associated with the route
    static func destination(for route: Self) -> Body
}

public extension Routable {
    nonisolated var id: Self { self }

    static func destination(for route: Self) -> Body {
        route.body
    }

    nonisolated func hash(into hasher: inout Hasher) {
        hasher.combine(self)
    }
}
