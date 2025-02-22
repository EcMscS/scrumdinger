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
    @Binding private var length: TimeInterval
    @Binding private var theme: Theme

    init(
        title: Binding<String>,
        length: Binding<TimeInterval>,
        theme: Binding<Theme>
    ) {
        self._title = title
        self._length = length
        self._theme = theme
    }

    var body: some View {
        Section(.meetingInfo) {
            TitleTextField(title: $title)
            LengthSlider(length: $length)
            ThemePicker(selection: $theme)
        }
    }
}
