//
//  Button.swift
//
//  Created by James Sedlacek on 3/2/24.
//

import Foundation
import XCTest

enum Button: String {
    // Navigation Bar Buttons
    case add
    case addAttendee = "Add Attendee"
    case backToDailyScrums = "Daily Scrums"
    case dismiss
    case edit
    case orange
    case paintpalette
    case plus

    // Action Buttons
    case delete

    var element: XCUIElement {
        switch self {
        case .add:
            XCUIApplication().navigationBars.buttons.element(boundBy: 2)
        case .dismiss:
            XCUIApplication().navigationBars.buttons[rawValue.capitalized]
        case .plus:
            XCUIApplication().navigationBars.buttons[rawValue]
        case .paintpalette:
            XCUIApplication().buttons[rawValue]
        default:
            XCUIApplication().buttons[rawValue.capitalized]
        }
    }
}
