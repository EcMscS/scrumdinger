//
//  Image+SFSymbol.swift
//
//  Created by James Sedlacek on 10/30/24.
//

import SwiftUI

extension Image {
    package enum SFSymbol: String {
        case calendar
        case calendarBadgeExclamationmark = "calendar.badge.exclamationmark"
        case clock
        case forward = "forward.fill"
        case hourglassBottom = "hourglass.bottomhalf.fill"
        case hourglassTop = "hourglass.tophalf.fill"
        case micActive = "mic"
        case micInactive = "mic.slash"
        case paintpalette
        case person
        case person3 = "person.3"
        case plus
        case timer
    }

    package init(_ symbol: SFSymbol) {
        self.init(systemName: symbol.rawValue)
    }
}
