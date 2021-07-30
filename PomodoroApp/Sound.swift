//
//  Sound.swift
//  PomodoroApp
//
//  Created by Vadim Dez on 05/05/16.
//  Copyright © 2016 Vadim Dez. All rights reserved.
//

import AppKit

class Sound {
    fileprivate let defaults = UserDefaults.standard
    
    /**
     * Check if can play
     */
    func canPlay() -> Bool {
        var play = 1
        if let soundsEnabled = self.defaults.value(forKey: DataKeys.sounds) {
            play = Int(truncating: soundsEnabled as! NSNumber)
        }
        
        return play == 1
    }
    
    func cycleEnded() {
        if self.canPlay() {
            var cycleSound: NSSound
            
            if let soundName = self.defaults.string(forKey: DataKeys.alertSound) {
                cycleSound = NSSound(named: soundName)!
            } else {
                cycleSound = NSSound(named: "Glass")!
            }
            
            cycleSound.volume = 0.5
            cycleSound.play()
        }
    }
}
