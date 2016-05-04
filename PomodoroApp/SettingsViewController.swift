//
//  SettingsViewController.swift
//  PomodoroApp
//
//  Created by Vadim Dez on 04/05/16.
//  Copyright © 2016 Vadim Dez. All rights reserved.
//

import Cocoa

class SettingsViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    @IBAction func dismissSettings(sender: AnyObject) {
        self.dismissViewController(self)
    }
}
