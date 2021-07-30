//
//  Sound.swift
//  PomodoroApp
//
//  Created by Vadim Dez on 05/05/16.
//  Copyright © 2016 Vadim Dez. All rights reserved.
//

import AppKit

class Sound {
    fileprivate let cycleSound: NSSound!
    fileprivate let defaults = UserDefaults.standard
    
    init() {
        self.cycleSound = NSSound(named: "ding")
        self.cycleSound.volume = 0.5
    }
    
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
            self.cycleSound.play()
        }
    }
}
