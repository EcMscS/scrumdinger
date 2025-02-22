//
//  StoredData.swift
//
//  Created by James Sedlacek on 2/20/25.
//

import SwiftUI

/// A property wrapper that provides access to shared DataStorage through SwiftUI's environment.
/// - Conforms to DynamicProperty for SwiftUI integration.
/// - Provides direct access to stored objects.
/// - Supports SwiftUI binding through projected value.
/// - Thread-safe with @MainActor attribute.
@MainActor
@propertyWrapper
public struct StoredData<T: Identifiable & Equatable & Codable>: DynamicProperty {
    /// The DataStorage instance retrieved from the environment.
    @Environment(DataStorage<T>.self) private var storage

    /// The wrapped value provides direct access to the stored objects array.
    /// - Get: Returns the current collection of objects.
    /// - Set: Replaces the entire collection with new objects.
    public var wrappedValue: [T] {
        get { storage.objects }
        nonmutating set { storage.replace(with: newValue) }
    }

    /// The projected value provides a SwiftUI binding to the objects array.
    /// - Returns: A binding that can be used in SwiftUI views.
    public var projectedValue: Binding<[T]> {
        .init(
            get: { wrappedValue },
            set: { wrappedValue = $0 }
        )
    }

    /// Creates a new StoredData instance.
    public init() {}

    /// Convenience method to update or insert a single object.
    /// - Parameter object: The object to upsert into storage.
    public func upsert(_ object: T) {
        storage.upsert(object)
    }
}
