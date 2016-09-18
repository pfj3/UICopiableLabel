//
//  UICopiableLabel.swift
//  CopiableLabelSubclass
//
//  Created by Peter Johnson on 5/12/15.
//

import UIKit

class UICopiableLabel: UILabel {
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.isUserInteractionEnabled = true
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: longPressSelectorString)
        self.addGestureRecognizer(longPressGesture)
        
    }
    
    let longPressSelectorString: Selector = #selector(UICopiableLabel.longPress(_:))
    func longPress(_ gestureRecognizer: UILongPressGestureRecognizer) {
        
        if gestureRecognizer.state != UIGestureRecognizerState.began {
            print("Continuous long press detected. Ignoring")
            return
        }
        
        print("Long press detected")
        
        becomeFirstResponder()
        let theMenu = UIMenuController.shared
        let copyItem = UIMenuItem(title: "Copy", action: copyToClipboardSelectorString)
        theMenu.menuItems = [copyItem]
        theMenu.setTargetRect(self.bounds, in: self)
        theMenu.setMenuVisible(true, animated: true)
    }
    
    let copyToClipboardSelectorString: Selector = #selector(UICopiableLabel.copyToClipboard)
    func copyToClipboard() {
        print("Copy called")
        UIPasteboard.general.string = self.text
    }
}
