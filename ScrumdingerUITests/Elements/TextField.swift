//
//  TextField.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Foundation
import XCTest

enum TextField: String {
    case newAttendee = "New Attendee"
    case title

    var element: XCUIElement {
        switch self {
        default:
            XCUIApplication().textFields[rawValue.capitalized]
        }
    }
}
