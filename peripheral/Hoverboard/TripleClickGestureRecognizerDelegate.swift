//
//  TripleClickGestureRecognizerDelegate.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/3/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import UIKit

class TripleClickGestureRecognizerDelegate: NSObject, UIGestureRecognizerDelegate {
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}