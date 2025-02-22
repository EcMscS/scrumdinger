//
//  Theme.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import SwiftUI

public enum Theme: String, CaseIterable, Identifiable, Hashable, Codable {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    
    public var accentColor: Color {
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow: return .black
        case .indigo, .magenta, .navy, .oxblood, .purple: return .white
        }
    }

    public var name: String {
        rawValue.capitalized
    }

    public var id: String {
        name
    }
}
