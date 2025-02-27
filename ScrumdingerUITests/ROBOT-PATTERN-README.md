# Robot Pattern Read Me

The **Robot Pattern** is a UI testing strategy that abstracts interactions with the app into reusable, structured "robot" classes. Instead of writing UI tests directly with raw `XCUIApplication` calls, robots encapsulate actions and verifications, making tests **more readable, maintainable, and modular**.  

## How It Works  

1. **Each screen or flow has its own robot**  
   - A **robot** is a helper class responsible for interacting with a specific part of the app (e.g., `AddScrumRobot`, `DetailScrumRobot`).  
   - It provides high-level methods like `fillOutScrumDetails()` or `validateScrumExists()`, abstracting away raw UI interactions.  

2. **Tests chain robot methods for clarity**  
   - Instead of writing verbose UI interactions in tests, you compose test steps using robot methods.  
   - Example:  
     ```swift
     AppRobot()
         .launchApp()
         .isOnAddScrumRobotScreen()
         .fillOutScrumDetails(title: "Design Meeting")
         .submitScrum()
         .validateScrumExists(title: "Design Meeting")
     ```  

This pattern makes UI tests **more reliable, scalable, and easier to work with**, especially as the app evolves.

## The Elements of a Robot

- **Broken into Elements, Verifications, and Actions**  
  A robot is structured around three key components:
  - **Elements**: The UI components the robot interacts with (e.g., buttons, text fields).
  - **Verifications**: Methods to check the state of the UI (e.g., `validateScrumExists()`).
  - **Actions**: Methods that perform actions on the UI (e.g., `fillOutScrumDetails()`).

- **Each Robot has an `init` Validating We Are on the Correct Screen**  
  The `init` method of each robot ensures that the app is in the correct screen state when the robot is instantiated. If not, it performs the necessary navigation or throws an error. This removes the need for explicit validation methods in the test, simplifying the flow and making the test code cleaner.

## Shared Logic

- Robots that share similar logic will conform to a protocol that is extended to share this logic.  
  An example of this is the `ScrumFormRobot` protocol, which provides shared logic between the `DetailScrumRobot` and the `AddScrumRobot`. These screens are very similar, but unique enough to require their own robots. By conforming to the same protocol, both robots can share common actions and verifications, reducing code duplication and increasing maintainability.

## The App Robot

At the core of the pattern is the **AppRobot**, responsible for launching the app and returning the robot for the initial screen. Every test starts by creating an `AppRobot`, ensuring a consistent entry point.

The `AppRobot` also manages common launch flows. For example, it includes `launchAppWithNewScrum()`, which not only launches the app but also sets up a basic scrum and verifies its creation. This makes it easy for tests that rely on this setup to use a standardized launch sequence.

