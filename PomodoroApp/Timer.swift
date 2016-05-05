//
//  Timer.swift
//  PomodoroApp
//
//  Created by Vadim Dez on 28/04/16.
//  Copyright © 2016 Vadim Dez. All rights reserved.
//

import Foundation

class Timer : NSObject {
    
    private var minutes: Int!
    private var seconds: Int!
    private var callback: (minutes: Int, seconds: Int) -> Void
    private var timer: NSTimer!
    
    init(minutes: Int, seconds: Int, callback: (minutes: Int, seconds: Int) -> Void) {
        self.minutes = minutes
        self.seconds = seconds
        self.callback = callback
    }
    
    
    func start() {
        self.setupTimer()
    }
    
    func stop() {
        if self.timer != nil {
            self.timer.invalidate()
        }
    }
    
    private func setupTimer() {
        if (self.timer !== nil) {
            self.timer.invalidate()
        }
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(cycle), userInfo: nil, repeats: true)
    }
    
    func cycle(sender: AnyObject) {
        self.seconds = self.seconds - 1
        
        if (self.seconds < 0) {
            self.seconds = 59
            self.minutes = self.minutes - 1
            
            if (self.minutes < 0) {
                self.stop()
                return;
            }
        }
        
        self.callback(minutes: self.minutes, seconds: self.seconds)
    }
    
    func setMinutes(minutes: Int) {
        self.minutes = minutes
    }
    
    func setSeconds(seconds: Int) {
        self.seconds = seconds
    }
}