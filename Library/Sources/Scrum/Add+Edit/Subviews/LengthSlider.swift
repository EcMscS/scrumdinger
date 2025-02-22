//
//  LengthSlider.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Extensions
import SwiftUI

@MainActor
struct LengthSlider: View {
    @Binding var length: TimeInterval

    var body: some View {
        HStack {
            Slider(
                value: $length,
                in: .minutes(5)...TimeInterval.minutes(30),
                step: .minutes(1)
            ) {
                Text(.length)
            }
            .accessibilityValue(.minutes(length.minutes))

            Spacer()

            Text(.minutes(length.minutes))
                .accessibilityHidden(true)
        }
    }
}
