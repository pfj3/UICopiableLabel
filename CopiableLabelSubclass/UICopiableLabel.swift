//
//  UICopiableLabel.swift
//  CopiableLabelSubclass
//
//  Created by Peter Johnson on 5/12/15.
//  Copyright (c) 2015 Peter Johnson. All rights reserved.
//

import UIKit

class UICopiableLabel: UILabel {
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userInteractionEnabled = true
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: Selector("longPress:"))
        self.addGestureRecognizer(longPressGesture)
        
    }
    
    func longPress(gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state != UIGestureRecognizerState.Began {
            println("Continuous long press detected. Ignoring")
            return
        }
        
        println("Long press detected")
        becomeFirstResponder()
        let theMenu = UIMenuController.sharedMenuController()
        let copyItem = UIMenuItem(title: "Copy", action: Selector("copyToClipboard"))
        theMenu.menuItems = [copyItem]
        theMenu.setTargetRect(self.bounds, inView: self)
        theMenu.setMenuVisible(true, animated: true)
    }
    
    func copyToClipboard() {
        println("Copy called")
        UIPasteboard.generalPasteboard().string = self.text
    }

}