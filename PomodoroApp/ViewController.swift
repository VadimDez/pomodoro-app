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
    @IBOutlet weak var bgImageView: NSImageView!
    @IBOutlet weak var progressImageView: NSImageView!
    @IBOutlet weak var startBtn: NSButton!
    @IBOutlet weak var stopBtn: NSButton!
    @IBOutlet var mainView: ColoredView!
    
    var timer: Timer!
    var countdownMinutes: Int!
    var countdownSeconds: Int!
    var isRest = false
    var defaults: NSUserDefaults!
    let sounds = Sound()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.defaults = NSUserDefaults.standardUserDefaults()
        
        self.setSessionTimes()
        
        self.stopBtn.hidden = true
        
        self.updateTimeLabels()
        
        self.timer = Timer(minutes: self.countdownMinutes, seconds: self.countdownSeconds, callback: self.callback)
        
        self.drawBackgroundCircle()
        
        self.mainView.backgroundColor = NSColor(red: 239/255, green: 35/255, blue: 60/255, alpha: 1.0)
    }
    
    override func viewDidAppear() {
        self.view.window?.titlebarAppearsTransparent = true
        self.view.window?.movableByWindowBackground = true
        self.view.window?.styleMask |= NSFullSizeContentViewWindowMask
    }
    
    func callback (minutes: Int, seconds: Int) {
        self.minutesLabel.stringValue = self.doubleNumber(minutes)
        self.secondsLabel.stringValue = self.doubleNumber(seconds)
        
        self.drawProgressCircle(Float(minutes * 60 + seconds) / Float(self.countdownMinutes * 60 + self.countdownSeconds))
        
        if (minutes == 0 && seconds == 0) {
            self.sounds.cycleEnded()
            
            if self.isRest {
                self.session()
            } else {
                self.rest()
            }
        }
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
        self.stop()
    }

    @IBAction func onStart(sender: AnyObject) {
        self.timer.start()
        
        self.startBtn.hidden = true
        self.stopBtn.hidden = false
    }
    
    @IBAction func showSettings(sender: AnyObject) {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let settingsViewController = storyboard.instantiateControllerWithIdentifier("settings") as! SettingsViewController
        
        self.presentViewControllerAsSheet(settingsViewController)
    }
    
    @IBAction func reset(sender: AnyObject) {
        self.stop()
        
        self.setSessionTimes()
        
        self.timer.setMinutes(self.countdownMinutes)
        self.timer.setSeconds(self.countdownSeconds)
        
        self.updateTimeLabels()
        
        self.drawProgressCircle(1)
    }
    
    func stop() {
        self.timer.stop()
        
        self.stopBtn.hidden = true
        self.startBtn.hidden = false
    }
    
    func drawBackgroundCircle() {
        
        let image = NSImage(size: self.view.frame.size)
        
        image.lockFocus()

        self.createCirclePath(NSColor(red: 1, green: 1, blue: 1, alpha: 1), startAngle: 0, endAngle: 360)
        
        image.unlockFocus()
        
        self.bgImageView.image = image
    }
    
    func drawProgressCircle(progressPercentage: Float) {
        let progressValue: CGFloat = CGFloat(progressPercentage * 360 + 90)
        let image = NSImage(size: self.view.frame.size)
        let color: NSColor
        
        image.lockFocus()
        
        if (self.isRest) {
            color = NSColor(red: 69/255, green: 105/255, blue: 144/255, alpha: 1)
        } else {
            color = NSColor(red: 237/255, green: 75/255, blue: 94/255, alpha: 1)
        }
        
        self.createCirclePath(color, startAngle: 450, endAngle: progressValue, clockwise: true)
        
        image.unlockFocus()
        
        self.progressImageView.image = image
    }
    
    func createCirclePath(color: NSColor, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool = false) -> NSBezierPath {
        let path = NSBezierPath()
        
        path.appendBezierPathWithArcWithCenter(self.getCenterPoint(), radius: 120, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        path.moveToPoint(NSPoint(x: 0, y: 0))
        
        color.setStroke()
        
        path.lineWidth = 20
        path.stroke()
        
        return path
    }
    
    func getCenterPoint() -> NSPoint {
        return  NSPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2 - 7)
    }
    
    func session() {
        self.isRest = false
        
        self.setSessionTimes()
        
        self.setBackgroudColor(239, g: 35, b: 60)
        
        self.resetCycle()
    }
    
    func rest() {
        self.isRest = true
        
        if let restLength = self.defaults.stringForKey(DataKeys.restLength) {
            self.countdownMinutes = Int(restLength)
        } else {
            self.defaults.setValue(5, forKey: DataKeys.sessionLength)
            self.countdownMinutes = 5
        }
        self.countdownSeconds = 0
        
        self.setBackgroudColor(69, g: 123, b: 157)
        
        self.resetCycle()
    }
    
    func resetCycle() {
        self.timer.setMinutes(self.countdownMinutes)
        self.timer.setSeconds(self.countdownSeconds)
        
        self.drawProgressCircle(0)
        
        self.timer.start()
    }
    
    func setBackgroudColor(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.mainView.backgroundColor = NSColor(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    
    
    func setSessionTimes() {
        if let sessionLength = self.defaults.stringForKey(DataKeys.sessionLength) {
            self.countdownMinutes = Int(sessionLength)
        } else {
            self.defaults.setValue(25, forKey: DataKeys.sessionLength)
            self.countdownMinutes = 25
        }
        self.countdownSeconds = 0
    }
    
    func updateTimeLabels() {
        self.minutesLabel.stringValue = "\(self.doubleNumber(self.countdownMinutes))"
        self.secondsLabel.stringValue = "\(self.doubleNumber(self.countdownSeconds))"
    }
}

