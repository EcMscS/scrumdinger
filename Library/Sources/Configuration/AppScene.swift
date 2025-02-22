//
//  AppScene.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Models
import SwiftUI

@MainActor
public struct AppScene<Content: View>: Scene {
    private let content: () -> Content
    @DataStore private var dailyScrumStore: [DailyScrum] = []

    public init(content: @escaping () -> Content) {
        self.content = content
    }

    public var body: some Scene {
        WindowGroup {
            content()
                .environment(_dailyScrumStore.storage)
        }
    }
}
