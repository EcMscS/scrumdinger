//
//  StartMeetingRow.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import SwiftUI

@MainActor
struct StartMeetingRow: View {
    let action: () -> Void

    var body: some View {
        Label(.startMeeting, symbol: .timer)
            .font(.headline)
            .foregroundStyle(Color.accentColor)
            .contentShape(.rect)
            .onTapGesture(perform: action)
    }
}
