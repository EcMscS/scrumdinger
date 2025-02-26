//
//  AppRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

import Foundation

class AppRobot: Robot {
    
    @discardableResult
    func launchApp() -> ScrumListRobot {
        app.launch()
        return ScrumListRobot()
    }

    @discardableResult
    func launchAppWithNewScrum(scrumName: String = "Design Meeting",
                               attendees: [String] = ["John", "Alice", "Bob"],
                               meetingLengthValue: CGFloat = 1.0,
                               meetingMinutes: Int = 30) -> ScrumListRobot {
        self.launchApp()
            .tapAppNewScrumButton()
            .inputTitleText(scrumName)
            .setLengthSlider(meetingLengthValue)
            .tapSelectThemeButton()
            .tapOrangeThemeButton()
            .addNewAttendees(attendees)
            .tapCreateScrumButton()
            .meetingTitleLabelExists(title: scrumName)
            .attendeeCountExists(attendeesCount: attendees.count)
            .meetingLengthLabel(minutes: meetingMinutes)
    }

    func terminateApp() {
        app.terminate()
    }
}
