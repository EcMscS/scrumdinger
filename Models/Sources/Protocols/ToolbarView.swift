//
//  ToolbarView.swift
//
//
//  Created by James Sedlacek on 5/24/24.
//

import SwiftUI

/// ToolbarView provides a standardized way to define toolbar content in SwiftUI views.
///
/// This protocol simplifies toolbar creation by requiring a single method that returns
/// toolbar content. It enforces a consistent pattern for toolbar implementation across views.
///
/// Usage:
/// ```swift
/// struct YourView: View, ToolbarView {
///     func toolbarContent() -> some ToolbarContent {
///         ToolbarItem(placement: .primaryAction) {
///             Button("Add") { /* action */ }
///         }
///     }
/// }
/// ```
public protocol ToolbarView {
    /// The type of toolbar content this view provides
    associatedtype Content: ToolbarContent

    /// Returns the toolbar content for this view
    /// - Returns: A toolbar content builder that defines the toolbar items
    @MainActor
    @ToolbarContentBuilder
    func toolbarContent() -> Content
}
