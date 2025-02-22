//
//  ProgressView.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import Foundation
import XCTest

enum ProgressView: String {
    case ring = "MeetingProgressRing"
    case speaker = "SpeakerProgressView"

    var element: XCUIElement {
        switch self {
        case .ring:
            XCUIApplication().otherElements[rawValue].firstMatch
        case .speaker:
            XCUIApplication().progressIndicators[rawValue].firstMatch
        }
    }
}
