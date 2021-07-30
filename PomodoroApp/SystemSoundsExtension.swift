//
//  SystemSoundsExtension.swift
//  PomodoroApp
//
//  Created by Vadim Yatsyuk on 30.07.21.
//  Copyright © 2021 Vadim Yatsyuk. All rights reserved.
//
import AppKit

extension NSSound {
    static var systemSounds: [String] {
        get {
            var returnArr =  [String]()
            let librarySources = (NSSearchPathForDirectoriesInDomains(.libraryDirectory, .allDomainsMask, true) as NSArray).objectEnumerator()
            
            var sourcePath = librarySources.nextObject() as? String
            while (sourcePath != nil) {
                
                let soundSource = FileManager.default.enumerator(atPath: URL(string: sourcePath!)!.appendingPathComponent("Sounds").absoluteString)
                var soundFile = soundSource?.nextObject() as? String
                while (soundFile != nil) {
                    let soundPath = URL(string: soundFile!)!.deletingPathExtension().absoluteString
                    if NSSound(named: soundPath) != nil {
                        returnArr.append(soundPath)
                    }
                    soundFile = soundSource?.nextObject() as? String
                }
                sourcePath = librarySources.nextObject() as? String
                
            }
            return returnArr
        }
    }
}
