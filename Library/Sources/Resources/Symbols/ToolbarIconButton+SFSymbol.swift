//
//  ToolbarIconButton+SFSymbol.swift
//
//  Created by James Sedlacek on 2/20/25.
//

import SwiftUI
import ViewComponents

extension ToolbarIconButton {
    package init(
        symbol: Image.SFSymbol,
        placement: ToolbarItemPlacement = .confirmationAction,
        perform action: @escaping () -> Void
    ) {
        self.init(
            systemName: symbol.rawValue,
            placement: placement,
            perform: action
        )
    }
}
