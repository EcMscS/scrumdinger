//
//  LengthSlider.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import SwiftUI

@MainActor
struct LengthSlider: View {
    @Binding var lengthInMinutes: Double

    var body: some View {
        HStack {
            Slider(value: $lengthInMinutes, in: 5...30, step: 1) {
                Text(.length)
            }
            .accessibilityValue(.minutes(Int(lengthInMinutes)))

            Spacer()

            Text(.minutes(Int(lengthInMinutes)))
                .accessibilityHidden(true)
        }
    }
}
