//
//  DoubleClickGestureRecognizerDelegate.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/3/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import UIKit

class DoubleClickGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        //var classAString = NSStringFromClass(gestureRecognizer.classForCoder)
        //var classBString = NSStringFromClass(otherGestureRecognizer.classForCoder)
        var shouldRecognize = false
        
        //println("Recognized a \(classBString) during a \(classAString)")
        
        return shouldRecognize
    }
}