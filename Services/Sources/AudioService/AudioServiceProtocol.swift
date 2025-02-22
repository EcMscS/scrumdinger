//
//  AudioServiceProtocol.swift
//
//  Created by James Sedlacek on 2/18/25.
//

import Foundation

/// Protocol defining the interface for audio playback services.
public protocol AudioServiceProtocol {
    /// Plays the specified sound file.
    /// - Parameter file: The sound file to play.
    /// - Throws: AudioServiceError if the sound file cannot be found or played.
    func play(_ file: SoundFile) throws(AudioServiceError)
}
