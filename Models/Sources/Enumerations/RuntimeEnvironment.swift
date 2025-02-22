//
//  RuntimeEnvironment.swift
//
//  Created by James Sedlacek on 2/22/25.
//

import SwiftUI

public enum RuntimeEnvironment: Equatable {
    case previews
    case simulator(String)
    case physicalDevice

    public static var current: RuntimeEnvironment {
        let environment = ProcessInfo.processInfo.environment

        if environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return .previews
        }
        if let simulatorName = environment["SIMULATOR_DEVICE_NAME"] {
            return .simulator(simulatorName)
        }
        return .physicalDevice
    }

    public var isPreview: Bool { self == .previews }
    public var isSimulator: Bool {
        if case .simulator = self { return true }
        return false
    }
    public var isPhysicalDevice: Bool { self == .physicalDevice }
}

extension RuntimeEnvironment: CustomStringConvertible {
    public var description: String {
        switch self {
        case .previews:
            return "Running in Xcode Previews"
        case .simulator(let name):
            return "Running in Simulator (\(name))"
        case .physicalDevice:
            return "Running on a Physical Device"
        }
    }
}
