//
//  AddScrumRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

import XCTest

//This is the scrum list robot
//Add Scrum robot is when you tap on add

class ScrumListRobot: Robot {
    //MARK: - Elements
    private var addScrumButton: XCUIElement {
        Button.plus.element
    }

    private var titleText: XCUIElement {
        Title.dailyScrums.element
    }

    private func attendeeCountLabel(count: Int) -> XCUIElement {
        app.staticTexts
            .matching(identifier: "\(count) attendees")
            .firstMatch
    }

    private func meetingLengthLabel(minutes: Int) -> XCUIElement {
            app.staticTexts
                .matching(identifier: "\(minutes) minute meeting")
                .firstMatch
    }


    //MARK: - Validation

    @discardableResult
    func isOnScrumListView() -> ScrumListRobot {
        XCTAssertTrue(titleText.exists)
        return self
    }

    @discardableResult
    func attendeeCountExists(attendeesCount: Int) -> ScrumListRobot {
        XCTAssertTrue(attendeeCountLabel(count: attendeesCount).exists)
        return self
    }

    @discardableResult
    func meetingLengthLabel(minutes: Int) -> ScrumListRobot {
        XCTAssertTrue(meetingLengthLabel(minutes: minutes).exists)
        return self
    }

    //MARK: - Interaction

    @discardableResult
    func tapAppNewScrumButton() -> AddScrumRobot {
        addScrumButton.tap()
        return AddScrumRobot()
    }

}


class AddScrumRobot: Robot {
    //MARK: - Elements

    private var dismissScrumButton: XCUIElement {
        Button.dismiss.element
    }

    private var scrumCard: XCUIElement {
        View.scrumCard.element
    }

    private var addScrumButton: XCUIElement {
        Button.add.element
    }

    //MARK: - Validation

    @discardableResult
    func isOnAddScrumView() -> AddScrumRobot {
        XCTAssertTrue(scrumCard.exists)
        return self
    }

    @discardableResult
    func tapCreateScrumButton() -> ScrumListRobot {
        addScrumButton.tap()
        return ScrumListRobot()
    }

    //MARK: - Interaction

    @discardableResult
    func tapDismissScrumButton() -> ScrumListRobot {
        dismissScrumButton.tap()
        return ScrumListRobot()
    }

}
