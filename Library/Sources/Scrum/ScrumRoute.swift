//
//  ScrumRoute.swift
//
//  Created by James Sedlacek on 2/14/25.
//

import Models
import Protocols
import SwiftUI

enum ScrumRoute: Routable, Codable {
    case add
    case detail(DailyScrum)
    case edit(DailyScrum)
    case history(History)
    case meeting(DailyScrum)

    var body: some View {
        switch self {
        case .add:
            AddScreen()
        case .detail(let dailyScrum):
            DetailScreen(dailyScrum)
        case .edit(let dailyScrum):
            EditScreen(dailyScrum)
        case .history(let history):
            HistoryScreen(history)
        case .meeting(let dailyScrum):
            MeetingScreen(dailyScrum)
        }
    }
}
