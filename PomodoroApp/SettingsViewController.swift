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
    @IBOutlet weak var doNotDisturbCheckbox: NSButton!
    @IBOutlet weak var alertSoundButton: NSPopUpButton!
    
    fileprivate var defaults: UserDefaults!
    fileprivate var hasErrors: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaults = UserDefaults.standard
        
        self.setTimes()
        self.setSounds()
        self.setStayOnTop()
        self.setDoNotDisturb()
        self.setAlertSounds()
    }
    
    @IBAction func onChange(_ sender: NSPopUpButtonCell) {
        defaults.setValue(sender.title, forKey: DataKeys.alertSound)
    }
    
    @IBAction func onSoundToggle(_ sender: NSButton) {
        defaults.setValue(sender.state, forKey: DataKeys.sounds)
        self.alertSoundButton.isEnabled = sender.state.rawValue == 1 ? true : false
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
            NSSound.beep()
            return
        }
        
        defaults.setValue(sessionLength, forKey: DataKeys.sessionLength)
        defaults.setValue(restLength, forKey: DataKeys.restLength)
        
        defaults.setValue(self.alwaysOnTopCheckbox.state, forKey: DataKeys.stayOnTop)
        defaults.setValue(self.doNotDisturbCheckbox.state, forKey: DataKeys.doNotDisturb)
        
        
        self.dismiss(self)
        
//        self.dismissViewController(self)
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
            let value = Int(truncating: soundsEnabled as! NSNumber)
            self.soundsCheckbox.state = NSControl.StateValue(rawValue: value)
            self.alertSoundButton.isEnabled = value == 1 ? true : false;
        } else {
            self.soundsCheckbox.state = NSControl.StateValue(rawValue: 1)
            self.alertSoundButton.isEnabled = true
        }
    }
    
    fileprivate func setAlertSounds() {
        self.alertSoundButton.removeAllItems()
        self.alertSoundButton.addItems(withTitles: NSSound.systemSounds)
        
        if let alertSound = self.defaults.string(forKey: DataKeys.alertSound) {
            self.alertSoundButton.selectItem(withTitle: alertSound)
        } else {
            self.alertSoundButton.selectItem(withTitle: NSSound.systemSounds[0])
        }
    }
    
    private func setStayOnTop() {
        if let stayOnTop = self.defaults.value(forKey: DataKeys.stayOnTop) {
            self.alwaysOnTopCheckbox.state = NSControl.StateValue(rawValue: Int(truncating: stayOnTop as! NSNumber))
            NSApplication.shared.activate(ignoringOtherApps: true)
        } else {
            self.alwaysOnTopCheckbox.state = NSControl.StateValue(rawValue: 0)
            NSApplication.shared.activate(ignoringOtherApps: false)
        }
    }
    
    private func setDoNotDisturb() {
        if let doNotDisturb = self.defaults.value(forKey: DataKeys.doNotDisturb) {
            self.doNotDisturbCheckbox.state = NSControl.StateValue(rawValue: Int(truncating: doNotDisturb as! NSNumber))
        } else {
            self.doNotDisturbCheckbox.state = NSControl.StateValue(rawValue: 0)
        }
    }
}
