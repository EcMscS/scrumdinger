//
//  ThemeRow.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Enumerations
import SwiftUI

@MainActor
struct ThemeRow: View {
    let theme: Theme

    var body: some View {
        HStack {
            Label(.theme, symbol: .paintpalette)
            Spacer()
            Text(theme.name)
                .padding(4)
                .foregroundStyle(theme.accentColor)
                .background(
                    theme.mainColor,
                    in: .rect(cornerRadius: 4)
                )
        }
        .accessibilityElement(children: .combine)
    }
}
