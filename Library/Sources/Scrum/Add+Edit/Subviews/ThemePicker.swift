//
//  ThemePicker.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Enumerations
import SwiftUI

@MainActor
struct ThemePicker: View {
    @Binding var selection: Theme

    var body: some View {
        Picker(.theme, selection: $selection) {
            ForEach(Theme.allCases) { theme in
                Label(theme.name, symbol: .paintpalette)
                    .tag(theme)
            }
        }
    }
}
