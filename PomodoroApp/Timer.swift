//
//  Timer.swift
//  PomodoroApp
//
//  Created by Vadim Dez on 28/04/16.
//  Copyright © 2016 Vadim Dez. All rights reserved.
//

import Foundation

class Timer : NSObject {
    
    fileprivate var minutes: Int!
    fileprivate var seconds: Int!
    fileprivate var callback: (_ minutes: Int, _ seconds: Int) -> Void
    fileprivate var timer: Foundation.Timer!
    
    init(minutes: Int, seconds: Int, callback: @escaping (_ minutes: Int, _ seconds: Int) -> Void) {
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
    
    fileprivate func setupTimer() {
        if (self.timer !== nil) {
            self.timer.invalidate()
        }
        
        self.timer = Foundation.Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(cycle), userInfo: nil, repeats: true)
    }
    
    func cycle(_ sender: AnyObject) {
        self.seconds = self.seconds - 1
        
        if (self.seconds < 0) {
            self.seconds = 59
            self.minutes = self.minutes - 1
            
            if (self.minutes < 0) {
                self.stop()
                return;
            }
        }
        
        self.callback(self.minutes, self.seconds)
    }
    
    func setMinutes(_ minutes: Int) {
        self.minutes = minutes
    }
    
    func setSeconds(_ seconds: Int) {
        self.seconds = seconds
    }
}
