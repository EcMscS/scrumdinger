//
//  ToolbarIconButton.swift
//
//  Created by James Sedlacek on 2/7/25.
//

import SwiftUI

@MainActor
public struct ToolbarIconButton: ToolbarContent {
    private let systemName: String
    private let placement: ToolbarItemPlacement
    private let action: () -> Void

    public init(
        systemName: String,
        placement: ToolbarItemPlacement = .confirmationAction,
        perform action: @escaping () -> Void
    ) {
        self.systemName = systemName
        self.placement = placement
        self.action = action
    }

    public var body: some ToolbarContent {
        ToolbarItem(placement: placement) {
            Button(action: action, label: labelView)
        }
    }

    private func labelView() -> some View {
        Image(systemName: systemName)
            .font(.system(size: 16, weight: .medium))
            .foregroundStyle(Color.blue)
    }
}
