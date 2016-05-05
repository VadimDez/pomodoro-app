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
    
    private var defaults: NSUserDefaults!
    private var hasErrors: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaults = NSUserDefaults.standardUserDefaults()
        
        self.setTimes()
        self.setSounds()
    }

    @IBAction func dismissSettings(sender: AnyObject) {
        let sessionLength = Int(self.sessionLengthField.stringValue)
        let restLength = Int(self.restLengthField.stringValue)
        
        self.hasErrors = false
        self.validate(sessionLength!, textField: self.sessionLengthField)
        self.validate(restLength!, textField: self.restLengthField)
        
        self.sessionLengthField.window?.makeFirstResponder(nil)
        self.restLengthField.window?.makeFirstResponder(nil)
        
        if (self.hasErrors) {
            NSBeep()
            return
        }
        
        defaults.setValue(sessionLength, forKey: DataKeys.sessionLength)
        defaults.setValue(restLength, forKey: DataKeys.restLength)
        defaults.setValue(self.soundsCheckbox.state, forKey: DataKeys.sounds)
        
        self.dismissViewController(self)
    }
    
    /**
     * Validate text field
     */
    private func validate(value: Int, textField: NSTextField) {
        if (value < 1) {
            self.hasErrors = true
            textField.backgroundColor = NSColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        } else {
            textField.backgroundColor = NSColor.whiteColor()
        }
    }
    
    private func setTimes() {
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
    
    private func setSounds() {
        if let soundsEnabled = self.defaults.valueForKey(DataKeys.sounds) {
            self.soundsCheckbox.state = Int(soundsEnabled as! NSNumber)
        } else {
            self.soundsCheckbox.state = 1
        }
    }
}
