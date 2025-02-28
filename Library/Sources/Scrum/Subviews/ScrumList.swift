//
//  ScrumList.swift
//
//  Created by James Sedlacek on 2/21/25.
//

import FileService
import Models
import Protocols
import Resources
import SwiftUI
import ViewComponents

@MainActor
struct ScrumList {
    @Environment(\.fileService) private var fileService
    @StoredData private var dailyScrums: [DailyScrum]
    private let cardTapAction: (DailyScrum) -> Void

    init(cardTapAction: @escaping (DailyScrum) -> Void) {
        self.cardTapAction = cardTapAction
    }

    private func loadData() {
        do throws(FileServiceError) {
            dailyScrums = try fileService.load(forKey: .dailyScrumsKey)
        } catch {
            if let description = error.errorDescription {
                print(description)
            }
        }
    }
}

extension ScrumList: View {
    var body: some View {
        List(dailyScrums, rowContent: scrumRow)
            .refreshable(action: loadData)
            .onAppear(perform: loadData)
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
