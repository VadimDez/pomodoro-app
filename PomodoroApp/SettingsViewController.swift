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
    
    var defaults: NSUserDefaults!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaults = NSUserDefaults.standardUserDefaults()
        
        self.setTimes()
    }

    @IBAction func dismissSettings(sender: AnyObject) {
        
        defaults.setValue(Int(self.sessionLengthField.stringValue), forKey: DataKeys.sessionLength)
        defaults.setValue(Int(self.restLengthField.stringValue), forKey: DataKeys.restLength)
        
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
}
