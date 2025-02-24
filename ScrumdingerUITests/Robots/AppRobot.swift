//
//  AppRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

class AppRobot: Robot {
    
    @discardableResult
    func launchApp() -> AddScrumRobot {
        app.launch()
        return AddScrumRobot()
    }

    func terminateApp() {
        app.terminate()
    }
}
