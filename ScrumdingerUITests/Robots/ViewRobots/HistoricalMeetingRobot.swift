//
//  HistoricalMeetingRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 25/02/2025.
//

import XCTest

class HistoricalMeetingRobot: Robot {

    init() {
        XCTAssertTrue(transcriptTitle.waitForExistence(timeout: 5), "Expected 'Historical Meeting' screen, but it didn't appear")
    }

    //MARK: - Elements

    private var transcriptTitle: XCUIElement {
        app.staticTexts["Transcript"]
    }

    func attendeeText(text: String) -> XCUIElement {
        app.staticTexts[text]
    }

    private var transcriptText: XCUIElement {
        app.staticTexts.matching(
            NSPredicate(format: "label CONTAINS[c] %@", "Transcript")
        ).firstMatch
    }

    //MARK: - Validation

    @discardableResult
    func speakerTextExists(text: String) -> HistoricalMeetingRobot {
        XCTAssertTrue(attendeeText(text: text).exists)
        return self
    }
    
    @discardableResult
    func transcriptTextExists() -> HistoricalMeetingRobot {
        XCTAssertTrue(transcriptText.exists)
        return self
    }

    //MARK: - Interaction

}
