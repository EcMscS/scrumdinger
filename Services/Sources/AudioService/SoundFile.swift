//
//  SoundFile.swift
//
//  Created by James Sedlacek on 2/18/25.
//

import Foundation

/// Represents the available sound files in the application.
/// Each case corresponds to a specific audio file resource.
public enum SoundFile: String, CaseIterable, Identifiable {
    case ding

    public var id: Self { self }

    var url: URL? {
        Bundle.module.url(
            forResource: rawValue,
            withExtension: "wav"
        )
    }
}
