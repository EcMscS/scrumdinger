//
//  HistorySection.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Models
import SwiftUI

@MainActor
struct HistorySection: View {
    let history: [History]
    let onHistoryTap: (History) -> Void

    private var isShowingEmptyHistory: Bool {
        history.isEmpty
    }

    var body: some View {
        Section(.history) {
            if isShowingEmptyHistory {
                Label(.noMeetingsYet, symbol: .calendarBadgeExclamationmark)
            } else {
                ForEach(history) { history in
                    HStack {
                        Image(.calendar)
                        Text(history.date, style: .date)
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        onHistoryTap(history)
                    }
                }
            }
        }
    }
}
