//
//  ColoredView.swift
//  PomodoroApp
//
//  Created by Vadim Dez on 02/05/16.
//  Copyright © 2016 Vadim Dez. All rights reserved.
//

import Cocoa

class ColoredView: NSView {
    var _backgroundColor: NSColor!
    var backgroundColor: NSColor {
        get {
            return self._backgroundColor
        }
        
        set (newVal) {
            self._backgroundColor = newVal
            self.needsDisplay = true
        }
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

        // Drawing code here.
    }
    
    override var wantsUpdateLayer: Bool {
        get {
            return true
        }
    }
    
    override func updateLayer() {
        self.layer?.backgroundColor = self._backgroundColor.CGColor
    }
}
