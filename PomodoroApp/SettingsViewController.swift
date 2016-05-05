//
//  SettingsViewController.swift
//  PomodoroApp
//
//  Created by Vadim Dez on 04/05/16.
//  Copyright © 2016 Vadim Dez. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {

    @IBOutlet weak var sessionLengthField: NSTextField!
    @IBOutlet weak var restLengthField: NSTextField!
    @IBOutlet weak var soundsCheckbox: NSButton!
    
    var defaults: NSUserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaults = NSUserDefaults.standardUserDefaults()
        
        self.setTimes()
        self.setSounds()
    }

    @IBAction func dismissSettings(sender: AnyObject) {
        let sessionLength = Int(self.sessionLengthField.stringValue)
        let restLength = Int(self.restLengthField.stringValue)
        var error = false
        
        if (sessionLength < 1) {
            error = true
            self.sessionLengthField.backgroundColor = NSColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        } else {
            self.sessionLengthField.backgroundColor = NSColor.whiteColor()
        }
        
        if (restLength < 1) {
            error = true
            self.restLengthField.backgroundColor = NSColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        } else {
            self.restLengthField.backgroundColor = NSColor.whiteColor()
        }
        
        self.sessionLengthField.window?.makeFirstResponder(nil)
        
        self.restLengthField.window?.makeFirstResponder(nil)
        
        if (error) {
            NSBeep()
            return
        }
        
        defaults.setValue(sessionLength, forKey: DataKeys.sessionLength)
        defaults.setValue(restLength, forKey: DataKeys.restLength)
        defaults.setValue(self.soundsCheckbox.state, forKey: DataKeys.sounds)
        
        self.dismissViewController(self)
    }
    
    func setTimes() {
        if let sessionLength = self.defaults.stringForKey(DataKeys.sessionLength) {
            self.sessionLengthField.stringValue = sessionLength
        } else {
            self.sessionLengthField.stringValue = "25"
        }
        
        if let restLength = self.defaults.stringForKey(DataKeys.restLength) {
            self.restLengthField.stringValue = restLength
        } else {
            self.restLengthField.stringValue = "5"
        }
    }
    
    func setSounds() {
        if let soundsEnabled = self.defaults.valueForKey(DataKeys.sounds) {
            self.soundsCheckbox.state = Int(soundsEnabled as! NSNumber)
        } else {
            self.soundsCheckbox.state = 1
        }
    }
}
