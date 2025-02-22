//
//  ToolbarButton.swift
//
//  Created by James Sedlacek on 2/7/25.
//

import SwiftUI

@MainActor
public struct ToolbarButton: ToolbarContent {
    private let title: LocalizedStringKey
    private let placement: ToolbarItemPlacement
    private let action: () -> Void

    public init(
        _ title: LocalizedStringKey,
        placement: ToolbarItemPlacement = .confirmationAction,
        perform action: @escaping () -> Void
    ) {
        self.title = title
        self.placement = placement
        self.action = action
    }

    public var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: action, label: labelView)
        }
    }

    private func labelView() -> some View {
        Text(title)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color.blue)
    }
}
