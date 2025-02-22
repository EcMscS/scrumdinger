//
//  DataStorage.swift
//
//  Created by James Sedlacek on 12/27/24.
//

import Foundation

/// A generic storage class that manages a collection of identifiable objects with optional file persistence.
/// - Provides in-memory storage with optional file system persistence.
/// - Supports CRUD operations (Create, Read, Update, Delete).
/// - Thread-safe with @MainActor attribute.
/// - Observable for SwiftUI integration.
@MainActor
@Observable
public class DataStorage<T: Identifiable & Equatable & Codable>: @preconcurrency Equatable {
    /// The current collection of stored objects.
    /// - Note: This property is read-only externally but can be modified through the provided methods.
    public private(set) var objects: [T]

    /// Optional file storage for persistence.
    private let fileStorage: FileStorage?

    /// Creates a new DataStorage instance.
    /// - Parameters:
    ///   - initialObjects: The initial collection of objects to store. Defaults to empty array.
    ///   - fileStorage: Optional FileStorage instance for persistence. If provided, data will be loaded from and saved to files.
    public init(
        initialObjects: [T] = [],
        fileStorage: FileStorage? = nil
    ) {
        self.objects = initialObjects
        self.fileStorage = fileStorage

        if let fileStorage {
            do {
                let key = String(describing: T.self)
                let loadedObjects: [T] = try fileStorage.load(forKey: key)
                objects = loadedObjects
            } catch {
                print("Error loading from file: \(error)")
            }
        }
    }

    /// Replaces all objects in the storage with a new collection.
    /// - Parameter newObjects: The new collection of objects to store.
    public func replace(with newObjects: [T]) {
        objects = newObjects
        saveToStorage()
    }

    /// Updates an existing object or inserts a new one into the storage.
    /// - Parameter object: The object to upsert.
    /// - Note: Objects are matched by their id property.
    public func upsert(_ object: T) {
        guard let index = objects.firstIndex(where: { $0.id == object.id }) else {
            // Object does not exist, append it.
            objects.append(object)
            saveToStorage()
            return
        }
        // Object exists, replace it.
        objects[index] = object
        saveToStorage()
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
        saveToStorage()
    }

    /// Removes all objects from the storage.
    public func deleteAll() {
        objects.removeAll()
        saveToStorage()
    }

    /// Persists the current state to file storage if available.
    /// - Note: This method is called automatically after any modification to the objects collection.
    private func saveToStorage() {
        guard let fileStorage else { return }

        do {
            let key = String(describing: T.self)
            try fileStorage.save(objects, forKey: key)
        } catch {
            print("Error saving to file: \(error)")
        }
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
