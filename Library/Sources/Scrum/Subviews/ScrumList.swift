//
//  ScrumList.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import Models
import Protocols
import Resources
import SwiftUI
import ViewComponents

@MainActor
struct ScrumList {
    @StoredData private var dailyScrums: [DailyScrum]
    private let cardTapAction: (DailyScrum) -> Void

    init(cardTapAction: @escaping (DailyScrum) -> Void) {
        self.cardTapAction = cardTapAction
    }
}

extension ScrumList: View {
    var body: some View {
        List(dailyScrums, rowContent: scrumRow)
    }

    private func scrumRow(_ scrum: DailyScrum) -> some View {
        ScrumCard(scrum)
            .listRowBackground(scrum.theme.mainColor)
            .contentShape(.rect)
            .onTapGesture {
                cardTapAction(scrum)
            }
    }
}
