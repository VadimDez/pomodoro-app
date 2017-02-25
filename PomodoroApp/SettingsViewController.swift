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
    @IBOutlet weak var alwaysOnTopCheckbox: NSButton!
    
    fileprivate var defaults: UserDefaults!
    fileprivate var hasErrors: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaults = UserDefaults.standard
        
        self.setTimes()
        self.setSounds()
        self.setStayOnTop()
    }

    @IBAction func dismissSettings(_ sender: AnyObject) {
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
        defaults.setValue(self.alwaysOnTopCheckbox.state, forKey: DataKeys.stayOnTop)
        
        self.dismissViewController(self)
    }
    
    /**
     * Validate text field
     */
    fileprivate func validate(_ value: Int, textField: NSTextField) {
        if (value < 1) {
            self.hasErrors = true
            textField.backgroundColor = NSColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        } else {
            textField.backgroundColor = NSColor.white
        }
    }
    
    fileprivate func setTimes() {
        if let sessionLength = self.defaults.string(forKey: DataKeys.sessionLength) {
            self.sessionLengthField.stringValue = sessionLength
        } else {
            self.sessionLengthField.stringValue = "25"
        }
        
        if let restLength = self.defaults.string(forKey: DataKeys.restLength) {
            self.restLengthField.stringValue = restLength
        } else {
            self.restLengthField.stringValue = "5"
        }
    }
    
    fileprivate func setSounds() {
        if let soundsEnabled = self.defaults.value(forKey: DataKeys.sounds) {
            self.soundsCheckbox.state = Int(soundsEnabled as! NSNumber)
        } else {
            self.soundsCheckbox.state = 1
        }
    }
    
    private func setStayOnTop() {
        if let stayOnTop = self.defaults.value(forKey: DataKeys.stayOnTop) {
            self.alwaysOnTopCheckbox.state = Int(stayOnTop as! NSNumber)
            NSApplication.shared().activate(ignoringOtherApps: true)
        } else {
            self.alwaysOnTopCheckbox.state = 0
            NSApplication.shared().activate(ignoringOtherApps: false)
        }
    }
}
