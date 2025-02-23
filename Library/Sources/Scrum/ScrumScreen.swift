//
//  ScrumScreen.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Models
import Protocols
import Resources
import SwiftUI
import ViewComponents

@MainActor
public struct ScrumScreen {
    @DataStore private var scrumPath: [ScrumRoute] = []
    @State private var routeToPresent: ScrumRoute? = nil

    public init() {}

    private func addAction() {
        routeToPresent = .add
    }

    private func cardTapAction(_ scrum: DailyScrum) {
        scrumPath.append(.detail(scrum))
    }
}

extension ScrumScreen: View {
    public var body: some View {
        NavigationStack(path: $scrumPath) {
            ScrumList(cardTapAction: cardTapAction)
                .navigationTitle(.dailyScrums)
                .navigationDestination(
                    for: ScrumRoute.self,
                    destination: ScrumRoute.destination
                )
                .sheet(
                    item: $routeToPresent,
                    content: ScrumRoute.destination
                )
                .toolbar(content: toolbarContent)
        }
        .environment(_scrumPath.storage)
    }
}

extension ScrumScreen: ToolbarView {
    public func toolbarContent() -> some ToolbarContent {
        ToolbarIconButton(symbol: .plus, perform: addAction)
    }
}
