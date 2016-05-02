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
    
    var timer: Timer!
    var countdownMinutes = 1
    let countdownSeconds = 0
    
    @IBOutlet var mainView: ColoredView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.minutesLabel.stringValue = "\(self.doubleNumber(self.countdownMinutes))"
        self.secondsLabel.stringValue = "\(self.doubleNumber(self.countdownSeconds))"
        
        
        self.timer = Timer(minutes: self.countdownMinutes, seconds: self.countdownSeconds, callback: self.callback)
        
        self.drawBackgroundCircle()
        
        self.mainView.backgroundColor = NSColor(red: 239/255, green: 35/255, blue: 60/255, alpha: 1.0)
    }
    
    func callback (minutes: Int, seconds: Int) {
        self.minutesLabel.stringValue = self.doubleNumber(minutes)
        self.secondsLabel.stringValue = self.doubleNumber(seconds)
        
        self.drawProgressCircle(Float(minutes * 60 + seconds) / Float(self.countdownMinutes * 60 + self.countdownSeconds))
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
    
    func drawBackgroundCircle() {
        
        let image = NSImage(size: self.view.frame.size)
        
        image.lockFocus()
        
        
        let path = NSBezierPath()
        
        let centerPoint = NSPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        
        path.appendBezierPathWithArcWithCenter(centerPoint, radius: 120, startAngle: 0, endAngle: 360)
        
        path.moveToPoint(NSPoint(x: 0, y: 0))
        
        NSColor(red: 1, green: 1, blue: 1, alpha: 1).setStroke()
        
        path.lineWidth = 20
        path.stroke()
        
        
        image.unlockFocus()
        
        self.bgImageView.image = image
    }
    
    func drawProgressCircle(progressPercentage: Float) {
        let progressValue: CGFloat = CGFloat(progressPercentage * 360 + 90)
        
        let image = NSImage(size: self.view.frame.size)
        
        image.lockFocus()
        
        let centerPoint = NSPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height / 2)
        let progress = NSBezierPath()
        progress.appendBezierPathWithArcWithCenter(centerPoint, radius: 120, startAngle: 450, endAngle: progressValue, clockwise: true)
        
        progress.moveToPoint(NSPoint(x: 0, y: 0))
        
        NSColor(red: 237/255, green: 75/255, blue: 94/255, alpha: 1).setStroke()
        
        progress.lineWidth = 20
        progress.stroke()
        
        
        image.unlockFocus()
        
        self.progressImageView.image = image
    }
}

