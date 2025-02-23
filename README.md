![Scrumdinger](https://github.com/user-attachments/assets/a245d11d-c260-42a8-8286-785ff491c68c)

# What is this?
Scrumdinger is an iOS app designed to help teams manage their daily scrum meetings effectively. <br>
In agile software development, a daily scrum is a short, time-boxed meeting where team members discuss their progress and plans.<br>

Here's how it works:
1. **Create a Scrum**: Set up a meeting with:
   - A custom title
   - Meeting length (5-30 minutes)
   - List of attendees
   - Visual theme for easy identification

2. **Run the Meeting**:
   - Start a timed session
   - The app automatically divides time equally among attendees
   - Visual progress indicators show overall meeting and current speaker progress
   - Optional audio recording with real-time transcription
   - Skip to next speaker when needed

3. **Review History**:
   - After each meeting, a history entry is created
   - View past meetings with full transcripts
   - Track who was in attendance

The app ensures meetings stay focused and on-time while maintaining a record of discussions for future reference.

# Why did I build this?
While this project started from Apple's tutorial, I saw it as an opportunity to showcase and implement modern iOS development practices. My focus was on:

1. **Modular Architecture**
   - Separating concerns into distinct packages
   - Creating reusable components

2. **Comprehensive Testing**
   - Automation testing via UI tests
   - Unit testing via Swift Testing

3. **Code Quality**
   - Following Swift best practices
   - Maintaining clear documentation

The goal was to transform a tutorial project into a production-ready application that demonstrates professional iOS development standards.

## Requirements
- iOS 17.0+
- Xcode 15.0+
- Swift 6.0+

## Installation
1. Clone the repository
2. Open `Scrumdinger.xcodeproj`
3. Build and run

# Features
1. **Daily Scrum Management:**
  - Create new scrums with title, length (5-30 minutes), and theme
  - Add and remove attendees
  - Edit existing scrums

2. **Meeting Features:**
  - Start timed meetings
  - Automatic time division between attendees
  - Visual progress tracking (ring for overall time, bar for current speaker)
  - Skip to next speaker
  - Audio recording and transcription
  - Ding sound that plays when it's the next attendee's turn to speak

3. **History and Review:**
  - Automatic history creation after meetings
  - View past meetings with date stamps
  - View attendee list for past meetings
  - Access meeting transcripts

# Contributions
We welcome contributions focused on:

1. **Architecture Improvements**
   - Code organization
   - Design patterns
   - Module structure
   - Dependency management

2. **Documentation**
   - Code comments
   - README updates
   - API documentation
   - Usage examples

3. **Testing**
   - Additional UI test coverage
   - Test refactoring
   - Test documentation
   - Performance testing

Please note that we are not accepting new feature additions at this time.

# Credits
Based on Apple's [iOS App Dev Training](https://developer.apple.com/tutorials/app-dev-training/getting-started-with-scrumdinger) <br>
Inspired by the [SyncUps](https://github.com/pointfreeco/syncups) project by Point-Free Co

