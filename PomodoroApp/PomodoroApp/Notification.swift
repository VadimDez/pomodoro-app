//
//  Notification.swift
//  PomodoroApp
//
//  Created by Clemens Putschli on 27/09/18.
//  Copyright © 2018 Clemens Putschli. All rights reserved.
//

import AppKit

class Notification {
    fileprivate let defaults = UserDefaults.standard
    
    init() {
       
    }
    
    func doNotDisturbEnabled() -> Bool{
        let doNotDisturb = self.defaults.bool(forKey: DataKeys.doNotDisturb)
        return doNotDisturb
    }

    func cycleStarted() {
        if self.doNotDisturbEnabled(){
            self.enableDND()
        }
    }
    
    func cycleEnded() {
        if self.doNotDisturbEnabled(){
            self.disableDND()
        }
    }
    
    func enableDND(){
        
        CFPreferencesSetValue("dndStart" as CFString, CGFloat(0) as CFPropertyList, "com.apple.notificationcenterui" as CFString, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost)
        
        CFPreferencesSetValue("dndEnd" as CFString, CGFloat(1440) as CFPropertyList, "com.apple.notificationcenterui" as CFString, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost)
        
        CFPreferencesSetValue("doNotDisturb" as CFString, true as CFPropertyList, "com.apple.notificationcenterui" as CFString, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost)
        
        
        commitDNDChanges()
    }
    
    func disableDND(){
        CFPreferencesSetValue("dndStart" as CFString, nil, "com.apple.notificationcenterui" as CFString, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost)
        
        CFPreferencesSetValue("dndEnd" as CFString, nil, "com.apple.notificationcenterui" as CFString, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost)
        
        CFPreferencesSetValue("doNotDisturb" as CFString, false as CFPropertyList, "com.apple.notificationcenterui" as CFString, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost)
        commitDNDChanges()
    }
    
    func commitDNDChanges(){
        CFPreferencesSynchronize("com.apple.notificationcenterui" as CFString, kCFPreferencesCurrentUser, kCFPreferencesCurrentHost)
        DistributedNotificationCenter.default().postNotificationName(NSNotification.Name(rawValue: "com.apple.notificationcenterui.dndprefs_changed"), object: nil, userInfo: nil, deliverImmediately: true)
    }
}
