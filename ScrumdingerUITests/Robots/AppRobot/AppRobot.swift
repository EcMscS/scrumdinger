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

    ///Launches the app and handles the standard process to add a new scrum meeting, validating the scrum details appear as expected in the scrum list
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
