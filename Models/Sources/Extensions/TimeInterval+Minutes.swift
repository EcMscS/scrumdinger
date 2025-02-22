//
//  TimeInterval+Minutes.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import Foundation

extension TimeInterval {
    /// Converts time interval to minutes by dividing by 60
    ///
    /// Example:
    /// ```swift
    /// let interval: TimeInterval = 300 // 5 minutes in seconds
    /// print(interval.minutes) // Prints: 5
    /// ```
    public var minutes: Int {
        Int(self / 60)
    }

    /// Creates a TimeInterval from a specified number of minutes
    ///
    /// Example:
    /// ```swift
    /// let fiveMinutes = TimeInterval.minutes(5) // Returns: 300 seconds
    /// ```
    /// - Parameter count: The number of minutes
    /// - Returns: A TimeInterval representing the specified minutes in seconds
    public static func minutes(_ count: Int) -> TimeInterval {
        TimeInterval(count * 60)
    }
}
