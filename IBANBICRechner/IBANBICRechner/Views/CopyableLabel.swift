//
//  CopyableLabel.swift
//  IBANBICRechner
//
//  Created by Christian Lobach on 24/05/15.
//  Copyright (c) 2015 Christian Lobach. All rights reserved.
//

import UIKit

class CopyableLabel: UILabel {

    override func canBecomeFirstResponder() -> Bool{
        return true
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        return action == "copy:"
    }
    
    override func copy(sender: AnyObject?) {
        UIPasteboard.generalPasteboard().string = text
    }
    
}
