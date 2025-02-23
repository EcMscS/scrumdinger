//
//  DataStorage.swift
//
//  Created by James Sedlacek on 12/27/24.
//

import Foundation

/// A generic storage class that manages a collection of identifiable objects.
/// - Supports CRUD operations (Create, Read, Update, Delete).
/// - Thread-safe with @MainActor attribute.
/// - Observable for SwiftUI integration.
@MainActor
@Observable
public class DataStorage<T: Identifiable & Equatable & Codable>: @preconcurrency Equatable {
    /// The current collection of stored objects.
    /// - Note: This property is read-only externally but can be modified through the provided methods.
    public private(set) var objects: [T]


    /// Creates a new DataStorage instance.
    /// - Parameters:
    ///   - initialObjects: The initial collection of objects to store. Defaults to empty array.
    public init(initialObjects: [T] = []) {
        self.objects = initialObjects
    }

    /// Replaces all objects in the storage with a new collection.
    /// - Parameter newObjects: The new collection of objects to store.
    public func replace(with newObjects: [T]) {
        objects = newObjects
    }

    /// Updates an existing object or inserts a new one into the storage.
    /// - Parameter object: The object to upsert.
    /// - Note: Objects are matched by their id property.
    public func upsert(_ object: T) {
        guard let index = objects.firstIndex(where: { $0.id == object.id }) else {
            // Object does not exist, append it.
            objects.append(object)
            return
        }
        // Object exists, replace it.
        objects[index] = object
    }

    /// Updates existing objects or inserts new ones into the storage.
    /// - Parameter objects: The array of objects to upsert.
    /// - Note: Objects are matched by their id property.
    public func upsert(_ objects: [T]) {
        objects.forEach { upsert($0) }
    }

    /// Deletes an object from the storage if it exists.
    /// - Parameter object: The object to delete.
    /// - Note: Objects are matched by their id property.
    public func delete(_ object: T) {
        guard let index = objects.firstIndex(where: { $0.id == object.id }) else {
            // Object does not exist, nothing to delete.
            return
        }
        // Object exists, remove it.
        objects.remove(at: index)
    }

    /// Removes all objects from the storage.
    public func deleteAll() {
        objects.removeAll()
    }

    /// Compares two DataStorage instances for equality.
    /// - Returns: True if both instances contain the same objects.
    public static func == (
        lhs: DataStorage<T>,
        rhs: DataStorage<T>
    ) -> Bool {
        return lhs.objects == rhs.objects
    }
}
