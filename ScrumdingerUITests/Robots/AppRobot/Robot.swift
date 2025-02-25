//
//  Robot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

import Foundation
import XCTest

protocol Robot {}

extension Robot {
    var app: XCUIApplication {
        XCUIApplication()
    }
}
