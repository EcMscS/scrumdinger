//
//  Button+SFSymbol.swift
//
//  Created by James Sedlacek on 2/18/25.
//

import SwiftUI

extension Button where Label == SwiftUI.Label<Text, Image> {
    package nonisolated init(
        _ titleKey: LocalizedStringKey,
        symbol: Image.SFSymbol,
        action: @escaping @MainActor () -> Void
    ) {
        self.init(
            titleKey,
            systemImage: symbol.rawValue,
            action: action
        )
    }
}
