//
//  Title.swift
//
//  Created by James Sedlacek on 3/2/24.
//

import Foundation
import XCTest

enum Title: String {
    case dailyScrums = "Daily Scrums"

    var element: XCUIElement {
        XCUIApplication().navigationBars[rawValue]
    }
}
