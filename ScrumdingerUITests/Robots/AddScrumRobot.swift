//
//  AddScrumRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

import XCTest

class AddScrumRobot: Robot {
    //MARK: - Elements

    private var addScrumButton: XCUIElement {
        Button.plus.element
    }

    private var titleText: XCUIElement {
        Title.dailyScrums.element
    }

    //MARK: - Validation

    @discardableResult
    func isOnAddScrumRobotScreen() -> AddScrumRobot {
        XCTAssertTrue(titleText.exists)
        return self
    }

    //MARK: - Interaction

    @discardableResult
    func tapAppScrumButton() -> AddScrumRobot {
        addScrumButton.tap()
        return self
    }

}
