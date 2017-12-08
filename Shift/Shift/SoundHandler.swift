//
//  SoundHandler.swift
//  Shift
//
//  Created by Joel Huggett on 2017-12-04.
//  Copyright © 2017 Joel Huggett. All rights reserved.
//

import Foundation
import AVFoundation

class SoundHandler {
    var players: [String: AVAudioPlayer] = [:]
    
    var duplicates: [AVAudioPlayer] = []
    
    init() {
        self.setUpSession()
        
    }
    
    func setUpSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func playSound(_ sound: String, _ format: String) {
        let vol: Float = 0.1
        if !DataManager.mute {
            self.duplicates = duplicates.filter({$0.isPlaying})
            if !self.players.filter({$0.key == sound}).isEmpty {
                if !self.players[sound]!.isPlaying {
                    self.players[sound]!.prepareToPlay()
                    print("found sound for: \(sound)")
                    self.players[sound]!.play()
                } else {
                    guard let url = Bundle.main.url(forResource: sound, withExtension: format) else { return }
                    let index = self.duplicates.count
                    self.duplicates.append(AVAudioPlayer())
                    do {
                        self.duplicates[index] = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                        self.duplicates[index].volume = vol
                        self.duplicates[index].prepareToPlay()
                        print("made duplicate of sound for: \(sound)")
                        self.duplicates[index].play()
                    } catch let error {
                        print(error.localizedDescription)
                    }
                }
            } else {
                guard let url = Bundle.main.url(forResource: sound, withExtension: format) else { return }
                self.players[sound] = AVAudioPlayer()
                do {
                    self.players[sound] = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                    guard let player = self.players[sound] else { return }
                    player.volume = vol
                    player.prepareToPlay()
                    print("new sound for: \(sound)")
                    player.play()
                } catch let error {
                    print(error.localizedDescription)
                }
            }
        }
    }
}


