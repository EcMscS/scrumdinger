//
//  AddScrumRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

import Foundation
import XCTest

class AddScrumRobot: Robot {

    init() {
        XCTAssertTrue(addScrumButton.waitForExistence(timeout: 5), "Expected 'AddScrumRobot' screen, but it didn't appear")
    }

    // MARK: - Elements
    private var addScrumButton: XCUIElement {
        Button.add.element
    }

    private var titleTextField: XCUIElement {
        TextField.title.element
    }

    private var durationSlider: XCUIElement {
        Slider.length.element
    }

    private var themeSelectionButton: XCUIElement {
        Button.paintpalette.element
    }

    private var themeOrangeButton: XCUIElement {
        Button.orange.element
    }

    private var themeNavyButton: XCUIElement {
        Button.oxblood.element
    }

    private var attendeeNameField: XCUIElement {
        TextField.newAttendee.element
    }

    private var addAttendeeButton: XCUIElement {
        Button.addAttendee.element
    }

    private func attendeeCell(for name: String) -> XCUIElement {
        app.staticTexts[name]
    }

    private  var deleteAttendeeButton: XCUIElement {
        Button.delete.element
    }

    private var cancelButton: XCUIElement {
        Button.cancel.element
    }

    private var doneButton: XCUIElement {
        Button.done.element
    }

    private var dismissScrumButton: XCUIElement {
        Button.dismiss.element
    }

    // MARK: - Validation

    // (Placeholder for validation methods, if needed)

    // MARK: - Interaction

    @discardableResult
    func inputScrumTitle(_ text: String) -> Self {
        titleTextField.tap()
        titleTextField.typeText(text)
        return self
    }

    @discardableResult
    func setDurationSlider(_ duration: CGFloat) -> Self {
        durationSlider.adjust(toNormalizedSliderPosition: duration)
        return self
    }

    @discardableResult
    func addAttendees(_ attendees: [String]) -> Self {
        attendees.forEach {
            attendeeNameField.tap()
            attendeeNameField.typeText($0)
            addAttendeeButton.tap()
        }
        return self
    }

    @discardableResult
    func deleteAttendee(named attendee: String) -> Self {
        attendeeCell(for: attendee).swipeLeft()
        deleteAttendeeButton.tap()
        return self
    }

    @discardableResult
    func tapCreateScrumButton() -> ScrumListRobot {
        addScrumButton.tap()
        return ScrumListRobot()
    }

    @discardableResult
    func tapDismissScrumButton() -> ScrumListRobot {
        dismissScrumButton.tap()
        return ScrumListRobot()
    }

    @discardableResult
    func tapThemeSelectionButton() -> AddScrumRobot {
        themeSelectionButton.tap()
        return self
    }

    @discardableResult
    func tapThemeOrangeButton() -> AddScrumRobot {
        themeOrangeButton.tap()
        return self
    }

    @discardableResult
    func tapThemeNavyButton() -> AddScrumRobot {
        themeNavyButton.tap()
        return self
    }

    @discardableResult
    func tapCancelButton() -> DetailScrumRobot {
        cancelButton.tap()
        return DetailScrumRobot()
    }

    @discardableResult
    func tapDoneButton() -> DetailScrumRobot {
        doneButton.tap()
        return DetailScrumRobot()
    }

}
