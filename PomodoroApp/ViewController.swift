//
//  ViewController.swift
//  PomodoroApp
//
//  Created by Vadim Dez on 28/04/16.
//  Copyright © 2016 Vadim Dez. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var minutesLabel: NSTextField!
    @IBOutlet weak var secondsLabel: NSTextField!
    
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.timer = Timer(minutes: 25, seconds: 0, callback: self.callback)
    }
    
    func callback (minutes: Int, seconds: Int) {
        self.minutesLabel.stringValue = self.doubleNumber(minutes)
        self.secondsLabel.stringValue = self.doubleNumber(seconds)
    }
    
    func doubleNumber(number: Int) -> String {
        return String("0\(number)".characters.suffix(2))
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onStop(sender: AnyObject) {
        self.timer.stop()
    }

    @IBAction func onStart(sender: AnyObject) {
        self.timer.start()
    }
}

