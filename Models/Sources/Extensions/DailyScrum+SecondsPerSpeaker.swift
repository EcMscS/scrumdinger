//
//  DailyScrum+SecondsPerSpeaker.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import Foundation
import Models

extension DailyScrum {
    // Divides total meeting time equally among all attendees
    public var secondsPerSpeaker: TimeInterval {
        length / TimeInterval(attendees.count)
    }
}
