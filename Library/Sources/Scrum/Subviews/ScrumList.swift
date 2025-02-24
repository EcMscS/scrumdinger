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
    @State private var errorToPresent: FileServiceError? = nil
    private let cardTapAction: (DailyScrum) -> Void

    private var isErrorPresented: Binding<Bool> {
        .constant(errorToPresent != nil)
    }

    init(cardTapAction: @escaping (DailyScrum) -> Void) {
        self.cardTapAction = cardTapAction
    }

    private func loadData() {
        do throws(FileServiceError) {
            dailyScrums = try fileService.load(forKey: .dailyScrumsKey)
        } catch {
            switch error {
            case .fileReadFailed(let error):
                print(error.localizedDescription)
            default:
                errorToPresent = error
            }
        }
    }
}

extension ScrumList: View {
    var body: some View {
        List(dailyScrums, rowContent: scrumRow)
            .refreshable(action: loadData)
            .onAppear(perform: loadData)
//            .alert(
//                isPresented: isErrorPresented,
//                error: errorToPresent,
//                actions: errorActions,
//                message: errorMessage
//            )
    }

    private func scrumRow(_ scrum: DailyScrum) -> some View {
        ScrumCard(scrum)
            .listRowBackground(scrum.theme.mainColor)
            .contentShape(.rect)
            .onTapGesture {
                cardTapAction(scrum)
            }
    }

    private func errorMessage(for error: LocalizedError) -> some View {
        Text(error.errorDescription ?? "Unknown error")
    }

    private func errorActions(for error: LocalizedError) -> some View {
        Button(.ok) {}
    }
}
