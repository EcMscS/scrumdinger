//
//  Slider.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Foundation
import XCTest

enum Slider: String {
    case length

    var element: XCUIElement {
        switch self {
        default:
            XCUIApplication().sliders[rawValue.capitalized]
        }
    }
}
