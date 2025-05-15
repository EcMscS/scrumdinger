//
//  MockAudioService.swift
//
//  Created by James Sedlacek on 2/17/25.
//

import Foundation

public class MockAudioService: @unchecked Sendable {
    private(set) var playedSounds: [SoundFile] = []
    private var shouldThrow: Bool = false

    public init(shouldThrow: Bool = false) {
        self.shouldThrow = shouldThrow
    }
}

extension MockAudioService: AudioServiceProtocol {
    public func play(_ file: SoundFile) throws(AudioServiceError) {
        if shouldThrow {
            throw .fileNotFound
        }
        playedSounds.append(file)
    }

    public func reset() {
        playedSounds.removeAll()
    }
}
