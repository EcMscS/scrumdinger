//
//  EditableMeetingInfoSection.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Enumerations
import SwiftUI

@MainActor
struct EditableMeetingInfoSection: View {
    @Binding private var title: String
    @Binding private var lengthInMinutes: Double
    @Binding private var theme: Theme

    init(
        title: Binding<String>,
        lengthInMinutes: Binding<Double>,
        theme: Binding<Theme>
    ) {
        self._title = title
        self._lengthInMinutes = lengthInMinutes
        self._theme = theme
    }

    var body: some View {
        Section(.meetingInfo) {
            TitleTextField(title: $title)
            LengthSlider(lengthInMinutes: $lengthInMinutes)
            ThemePicker(selection: $theme)
        }
    }
}
