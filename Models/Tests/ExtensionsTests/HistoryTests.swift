import Foundation
import Testing

@testable import Extensions
@testable import Models

struct HistoryTests {
    @Test func testEmptyAttendeesList() async throws {
        let history = History(attendees: [])
        #expect(history.attendeeString == "")
    }

    @Test func testSingleAttendee() async throws {
        let history = History(attendees: [.init(name: "John")])
        #expect(history.attendeeString == "John")
    }

    @Test func testTwoAttendees() async throws {
        let history = History(attendees: [
            .init(name: "John"),
            .init(name: "Jane")
        ])
        #expect(history.attendeeString == "John and Jane")
    }

    @Test func testThreeAttendees() async throws {
        let history = History(attendees: [
            .init(name: "John"),
            .init(name: "Jane"),
            .init(name: "Bob")
        ])
        #expect(history.attendeeString == "John, Jane, and Bob")
    }

    @Test func testMockHistory() async throws {
        let history = History.mock()
        #expect(history.attendeeString == "Jon and Darla")
    }
}
