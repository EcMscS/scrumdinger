//
//  MeetingLengthRow.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Extensions
import SwiftUI

@MainActor
struct MeetingLengthRow: View {
    let length: TimeInterval

    var body: some View {
        HStack {
            Label(.length, symbol: .clock)
            Spacer()
            Text(.minutes(length.minutes))
        }
        .accessibilityElement(children: .combine)
    }
}
