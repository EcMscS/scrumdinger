//
//  MeetingInfoSection.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Enumerations
import Models
import SwiftUI

@MainActor
struct MeetingInfoSection: View {
    let scrum: DailyScrum
    let startMeetingAction: () -> Void

    var body: some View {
        Section(.meetingInfo) {
            StartMeetingRow(action: startMeetingAction)
            MeetingLengthRow(lengthInMinutes: scrum.lengthInMinutes)
            ThemeRow(theme: scrum.theme)
        }
    }
}
