//
//  Button.swift
//
//  Created by James Sedlacek on 3/2/24.
//

import Foundation
import XCTest

enum Button: String {
    case add
    case addAttendee = "Add Attendee"
    case backToDailyScrums = "Daily Scrums"
    case cancel
    case delete
    case dismiss
    case done
    case edit
    case end
    case forward = "forward.fill"
    case orange
    case oxblood
    case paintpalette
    case plus
    case startMeeting = "Start Meeting"

    var element: XCUIElement {
        switch self {
        case .add:
            XCUIApplication().navigationBars.buttons.element(boundBy: 2)
        case .dismiss:
            XCUIApplication().navigationBars.buttons[rawValue.capitalized]
        case .plus:
            XCUIApplication().navigationBars.buttons[rawValue]
        case .forward, .paintpalette:
            XCUIApplication().buttons[rawValue]
        case .startMeeting:
            XCUIApplication().staticTexts[rawValue]
        default:
            XCUIApplication().buttons[rawValue.capitalized]
        }
    }
}
