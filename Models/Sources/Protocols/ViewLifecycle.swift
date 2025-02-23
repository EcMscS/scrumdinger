//
//  ViewLifecycle.swift
//
//  Created by James Sedlacek on 11/8/24.
//

/// ViewLifecycle provides a standardized way to handle view lifecycle events.
///
/// This protocol defines three main lifecycle events:
/// - `onTask`: Called when an async task begins
/// - `onAppear`: Called when the view appears
/// - `onDisappear`: Called when the view disappears
///
/// Usage:
/// ```swift
/// struct YourView: View, ViewLifecycle {
///     func onAppear() {
///         // Setup when view appears
///     }
///
///     func onDisappear() {
///         // Cleanup when view disappears
///     }
/// }
/// ```
@MainActor
public protocol ViewLifecycle {
    /// Called when an async task begins
    /// - Note: This is useful for initiating async operations when the view loads
    func onTask() async

    /// Called when the view appears in the interface
    /// - Note: Use this for setup code that needs to run when the view becomes visible
    func onAppear()

    /// Called when the view disappears from the interface
    /// - Note: Use this for cleanup code that needs to run when the view is no longer visible
    func onDisappear()
}

extension ViewLifecycle {
    public func onTask() async {}
    public func onAppear() {}
    public func onDisappear() {}
}
