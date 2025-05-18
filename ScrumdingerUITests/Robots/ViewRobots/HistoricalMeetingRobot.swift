//
//  HistoricalMeetingRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 25/02/2025.
//

import XCTest

class HistoricalMeetingRobot: Robot {

    init() {
        XCTAssertTrue(
          transcriptTitle.waitForExistence(timeout: 5),
          "Expected 'Historical Meeting' screen, but it didn't appear"
        )
    }

    // MARK: - Elements

    private var transcriptTitle: XCUIElement {
        app.staticTexts["Transcript"]
    }

    private func speakerLabel(named name: String) -> XCUIElement {
        app.staticTexts[name]
    }

    private var transcriptText: XCUIElement {
        app.staticTexts.matching(
            NSPredicate(format: "label CONTAINS[c] %@", "Transcript")
        ).firstMatch
    }

    // MARK: - Validations

    @discardableResult
    func verifySpeakersExists(named name: String) -> Self {
        XCTAssertTrue(speakerLabel(named: name).exists)
        return self
    }

    @discardableResult
    func verifyTranscriptExists() -> Self {
        XCTAssertTrue(transcriptText.exists)
        return self
    }

    // MARK: - Interactions
}
