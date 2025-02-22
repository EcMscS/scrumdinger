//
//  Color+Theme.swift
//
//  Created by James Sedlacek on 2/15/25.
//

import Enumerations
import SwiftUI

extension Color {
    init(_ theme: Theme) {
        self.init(theme.rawValue, bundle: .module)
    }
}

extension Theme {
    public var mainColor: Color {
        .init(self)
    }
}
