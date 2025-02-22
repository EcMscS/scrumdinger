//
//  Routable.swift
//
//  Created by James Sedlacek on 2/7/25.
//

import SwiftUI

public protocol Routable: Hashable, View, Identifiable {
    var id: Self { get }
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
