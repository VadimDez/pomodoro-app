//
//  Sound.swift
//  PomodoroApp
//
//  Created by Vadim Dez on 05/05/16.
//  Copyright © 2016 Vadim Dez. All rights reserved.
//

import AppKit

class Sound {
    private let cycleSound: NSSound!
    
    init() {
        self.cycleSound = NSSound(named: "ding")
        self.cycleSound.volume = 0.5
    }
    
    func cycleEnded() {
        self.cycleSound.play()
    }
}