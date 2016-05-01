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
    @IBOutlet var mainView: NSView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.timer = Timer(minutes: 25, seconds: 0, callback: self.callback)
        
        self.drawCircle()
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
    
    func drawCircle() {
        
        let width: CGFloat = self.view.frame.size.width;
        let height: CGFloat = self.view.frame.size.height
        
        let frameRect = NSRect(x: 0, y: 0, width: width, height: height)
        let image = NSImage(size: self.view.frame.size)
        
        image.lockFocus()
        
        
        let path = NSBezierPath()
        
        let centerPoint = NSPoint(x: width / 2, y: height / 2)
        
        path.appendBezierPathWithArcWithCenter(centerPoint, radius: 120, startAngle: 0, endAngle: 360)
        
        path.moveToPoint(NSPoint(x: 0, y: 0))
        
        path.lineWidth = 20
        path.stroke()
        
        
        image.unlockFocus()
        
        
        let view2 = NSImageView(frame: frameRect)
        view2.image = image
        self.view.addSubview(view2)
    }
}

