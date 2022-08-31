//
//  AudioPlayer.swift
//  Restart
//
//  Created by Martin Stofko on 8/30/22.
//

import Foundation
import AVFoundation

final class AudioPlayer {
    static let shared = AudioPlayer()
    
    private var audioPlayer: AVAudioPlayer?
    
    func playSound(sound: String, type: String) {
        guard let path = Bundle.main.path(forResource: sound, ofType: type) else {
            print("Could not find the sound file.")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("Could not play the sound file.")
        }
    }
}
