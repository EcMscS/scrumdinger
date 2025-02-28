# Robot Pattern  

The Robot Pattern is a UI testing strategy that abstracts interactions with the app into reusable, structured "robot" classes. Instead of writing UI tests directly with raw `XCUIApplication` calls, robots encapsulate actions and verifications, making tests more readable, maintainable, and modular.  

---

## How It Works  

### 1. Each screen or flow has its own robot  
- A robot is a helper class responsible for interacting with a specific part of the app (e.g., `AddScrumRobot`, `DetailScrumRobot`).  
- It provides high-level methods like `setDurationSlider()` or `addAttendees()`, abstracting away raw UI interactions.  

### 2. Tests chain robot methods for clarity  
- Each robot method returns the robot for the next part of the flow. This could be the same robot if the test continues on the same screen or a different robot if the test moves to another part of the app.  
- This makes tests fluent and readable, ensuring each step naturally leads to the next.  

#### Example:  
```swift
AppRobot()
    .launchApp() // Returns ScrumListRobot
    .tapAddScrumButton() // Returns AddScrumRobot
    .tapCreateScrumButton() // Stays on AddScrumRobot
    .verifyAttendeeCountExists(count: 0) // Stays on AddScrumRobot
    .verifyMeetingLengthExists(minutes: 5) // Stays on AddScrumRobot
```

## The Elements of a Robot

- **Broken into Elements, Verifications, and Actions**  
  A robot is structured around three key components:
  - **Elements**: The UI components the robot interacts with (e.g., buttons, text fields).
  - **Verifications**: Methods to check the state of the UI (e.g., `validateScrumExists()`).
  - **Actions**: Methods that perform actions on the UI (e.g., `fillOutScrumDetails()`).

- **Each Robot has an `init` Validating We Are on the Correct Screen**  
  The `init` method of each robot ensures that the app is in the correct screen state when the robot is instantiated. If not, it performs the necessary navigation or throws an error. This removes the need for explicit validation methods in the test, simplifying the flow and making the test code cleaner.

## The App Robot

At the core of the pattern is the AppRobot, responsible for launching the app and returning the robot for the initial screen. Every test starts by creating an `AppRobot`, ensuring a consistent entry point.

The `AppRobot` also manages common launch flows. For example, it includes `launchAppWithNewScrum()`, which not only launches the app but also sets up a basic scrum and verifies its creation. This makes it easy for tests that rely on this setup to use a standardized launch sequence.

