import Enumerations
import Resources
import SwiftUI
import ViewComponents

@MainActor
struct MeetingHeaderView {
    private let secondsElapsed: TimeInterval
    private let secondsRemaining: TimeInterval
    private let theme: Theme

    init(
        secondsElapsed: TimeInterval,
        secondsRemaining: TimeInterval,
        theme: Theme
    ) {
        self.secondsElapsed = secondsElapsed
        self.secondsRemaining = secondsRemaining
        self.theme = theme
    }

    private var totalSeconds: TimeInterval {
        secondsElapsed + secondsRemaining
    }

    private var progress: TimeInterval {
        guard totalSeconds > 0 else { return 1 }
        return secondsElapsed / totalSeconds
    }

    private var minutesRemaining: Int {
        secondsRemaining.minutes
    }
}

extension MeetingHeaderView: View {
    var body: some View {
        VStack {
            progressView
            timeLabelsRow
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(.timeRemaining)
        .accessibilityValue(.timeRemaining(minutes: minutesRemaining))
        .padding([.top, .horizontal])
    }

    private var progressView: some View {
        ProgressView(value: progress)
            .tint(theme.mainColor)
            .progressViewStyle(.rounded(background: theme.accentColor))
    }

    private var timeLabelsRow: some View {
        HStack {
            elapsedTimeColumn
            Spacer()
            remainingTimeColumn
        }
    }

    private var elapsedTimeColumn: some View {
        VStack(alignment: .leading) {
            Text(.secondsElapsed)
                .font(.caption)
            Label("\(secondsElapsed)", symbol: .hourglassBottom)
        }
    }

    private var remainingTimeColumn: some View {
        VStack(alignment: .trailing) {
            Text(.secondsRemaining)
                .font(.caption)
            Label("\(secondsRemaining)", symbol: .hourglassTop)
                .labelStyle(.trailingIcon)
        }
    }
}

#Preview {
    MeetingHeaderView(
        secondsElapsed: 60,
        secondsRemaining: 180,
        theme: .bubblegum
    )
}
