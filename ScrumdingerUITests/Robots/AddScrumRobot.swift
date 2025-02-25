//
//  AddScrumRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

import XCTest

class AddScrumRobot: Robot {

    init() {
        XCTAssertTrue(addScrumButton.waitForExistence(timeout: 5), "Expected 'AddScrumRobot' screen, but it didn't appear")
    }

    //MARK: - Elements
    private var dismissScrumButton: XCUIElement {
        Button.dismiss.element
    }
    
    private var addScrumButton: XCUIElement {
        Button.add.element
    }

    private var titleTextField: XCUIElement {
        TextField.title.element
    }

    private var lengthSlider: XCUIElement {
        Slider.length.element
    }

    private var selectThemeButton: XCUIElement {
        Button.paintpalette.element
    }

    private var orangeThemeButton: XCUIElement {
        Button.orange.element
    }

    private var attendeeField: XCUIElement {
        TextField.newAttendee.element
    }

    private var addAttendeeButton: XCUIElement {
        Button.addAttendee.element
    }

    func attendeeCell(for name: String) -> XCUIElement {
        app.staticTexts[name]
    }

    private var deleteButton: XCUIElement {
        Button.delete.element
    }

    //MARK: - Validation
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

    @discardableResult
    func tapSelectThemeButton() -> AddScrumRobot {
        selectThemeButton.tap()
        return self
    }

    @discardableResult
    func tapOrangeThemeButton() -> AddScrumRobot {
        orangeThemeButton.tap()
        return self
    }

    @discardableResult
    func inputTitleText(_ text: String) -> AddScrumRobot {
        titleTextField.tap()
        titleTextField.typeText(text)
        return self
    }

    @discardableResult
    func setLengthSlider(_ length: CGFloat) -> AddScrumRobot {
        lengthSlider.adjust(toNormalizedSliderPosition: length)
        return self
    }

    @discardableResult
    func addNewAttendee(_ attendee: String) -> AddScrumRobot {
        attendeeField.tap()
        attendeeField.typeText(attendee)
        addAttendeeButton.tap()
        return self
    }

    @discardableResult
    func deleteAttendee(_ attendee: String) -> AddScrumRobot {
        attendeeCell(for: attendee).swipeLeft()
        deleteButton.tap()
        return self
    }
}
