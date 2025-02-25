//
//  AppRobot.swift
//  Scrumdinger
//
//  Created by Matt Heaney on 24/02/2025.
//

class AppRobot: Robot {
    
    @discardableResult
    func launchApp() -> ScrumListRobot {
        app.launch()
        return ScrumListRobot()
    }

    func terminateApp() {
        app.terminate()
    }
}
