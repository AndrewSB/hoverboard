//
//  DragWhilePointingGestureRecognizerDelegate.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/21/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import UIKit

class DragWhilePointingGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        switch otherGestureRecognizer {
        case pointGestureRecognizer:
            return true
        default:
            return false
        }
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        switch pointGestureRecognizer.state {
        case .Began, .Changed:
            return true
        case .Cancelled, .Ended, .Failed, .Possible:
            return true
        }
    }
}