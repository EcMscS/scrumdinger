//
//  DataStore.swift
//
//  Created by James Sedlacek on 2/20/25.
//

import SwiftUI

/// A property wrapper that provides a convenient way to store and manage collections of identifiable objects.
/// - Manages a DataStorage instance internally.
/// - Provides direct access to the stored objects array.
/// - Supports SwiftUI binding through projected value.
/// - Thread-safe with @MainActor attribute.
@MainActor
@propertyWrapper
public struct DataStore<T: Identifiable & Equatable & Codable> {
    /// The underlying storage instance that manages the data.
    @State public private(set) var storage: DataStorage<T>

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

    /// Creates a new DataStore instance.
    /// - Parameters:
    ///   - wrappedValue: The initial collection of objects. Defaults to empty array.
    public init(wrappedValue: [T] = []) {
        _storage = State(
            initialValue: DataStorage(initialObjects: wrappedValue)
        )
    }
}
