//
//  HistoryScreen.swift
//
//  Created by James Sedlacek on 2/15/25.
//

import Extensions
import Models
import SwiftUI

@MainActor
struct HistoryScreen {
    private let history: History

    init(_ history: History) {
        self.history = history
    }
}

extension HistoryScreen: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Divider()
                    .padding(.bottom)

                Text(.attendees)
                    .font(.headline)

                Text(history.attendeeString)

                transcriptView
            }
        }
        .navigationTitle(dateText)
        .padding()
    }

    private var dateText: Text {
        Text(history.date, style: .date)
    }

    @ViewBuilder
    private var transcriptView: some View {
        if let transcript = history.transcript {
            Text(.transcript)
                .font(.headline)
                .padding(.top)

            Text(transcript)
        }
    }
}

#Preview {
    NavigationStack {
        HistoryScreen(.mock())
    }
}
