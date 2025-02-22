import Models
import SwiftUI

@MainActor
struct MeetingFooterView {
    private let activeSpeaker: DailyScrum.Attendee?
    private let speakers: [DailyScrum.Attendee]
    private let skipAction: () -> Void

    init(
        activeSpeaker: DailyScrum.Attendee?,
        speakers: [DailyScrum.Attendee],
        skipAction: @escaping () -> Void = {}
    ) {
        self.activeSpeaker = activeSpeaker
        self.speakers = speakers
        self.skipAction = skipAction
    }

    private var speakerNumber: Int? {
        guard let activeSpeaker,
              let index = speakers.firstIndex(of: activeSpeaker)
        else { return nil }
        return index + 1
    }

    private var isLastSpeaker: Bool {
        guard let activeSpeaker,
              let index = speakers.firstIndex(of: activeSpeaker)
        else { return false }
        return index == speakers.count - 1
    }

    private var footerText: LocalizedStringKey {
        guard let speakerNumber else { return .noSpeakers }
        return isLastSpeaker ? .lastSpeaker : .speakerCount(speakerNumber, speakers.count)
    }
}

extension MeetingFooterView: View {
    var body: some View {
        HStack {
            Text(footerText)

            if !isLastSpeaker {
                Spacer()
                skipButton
            }
        }
        .padding([.bottom, .horizontal])
    }

    private var skipButton: some View {
        Button(action: skipAction) {
            Image(.forward)
        }
        .accessibilityLabel(.nextSpeaker)
    }
}

#Preview("No Speakers") {
    MeetingFooterView(
        activeSpeaker: nil,
        speakers: []
    )
}

#Preview("One Speaker") {
    let speaker = DailyScrum.Attendee(id: UUID(), name: "John")
    return MeetingFooterView(
        activeSpeaker: speaker,
        speakers: [speaker]
    )
}

#Preview("Multiple Speakers") {
    let john = DailyScrum.Attendee(id: UUID(), name: "John")
    let jane = DailyScrum.Attendee(id: UUID(), name: "Jane")
    let bob = DailyScrum.Attendee(id: UUID(), name: "Bob")
    return MeetingFooterView(
        activeSpeaker: john,
        speakers: [john, jane, bob]
    )
}

#Preview("Last Speaker") {
    let john = DailyScrum.Attendee(id: UUID(), name: "John")
    let jane = DailyScrum.Attendee(id: UUID(), name: "Jane")
    let bob = DailyScrum.Attendee(id: UUID(), name: "Bob")
    return MeetingFooterView(
        activeSpeaker: bob,
        speakers: [john, jane, bob]
    )
}
