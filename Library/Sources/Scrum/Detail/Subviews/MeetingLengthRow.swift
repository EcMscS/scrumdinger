//
//  MeetingLengthRow.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import SwiftUI

@MainActor
struct MeetingLengthRow: View {
    let lengthInMinutes: Int

    var body: some View {
        HStack {
            Label(.length, symbol: .clock)
            Spacer()
            Text(.minutes(lengthInMinutes))
        }
        .accessibilityElement(children: .combine)
    }
}
