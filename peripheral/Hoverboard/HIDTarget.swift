//
//  HIDTarget.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/2/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import UIKit
import CoreGraphics

class HIDTarget: NSObject {
        func point(recognizer: UIPanGestureRecognizer) {
            var translation = recognizer.translationInView(mainView)
            var velocity = recognizer.velocityInView(mainView)
            var formatter = NSNumberFormatter()
    
            formatter.numberStyle = .DecimalStyle
            formatter.usesGroupingSeparator = false;
            formatter.maximumFractionDigits = 3
            formatter.minimumFractionDigits = 1
    
            var vx = abs(velocity.x) / 500
            var vy = abs(velocity.y) / 500
            var tx = translation.x * vx
            var ty = translation.y * vy
    
            var stringTranslationYWithVelocity = formatter.stringFromNumber(ty)!
            var stringTranslationYWithVelocity = formatter.stringFromNumber(ty)!
            var packetString = "\(stringTranslationXWithVelocity),\(stringTranslationYWithVelocity)"
            var packetData = packetString.dataUsingEncoding(NSUTF8StringEncoding)
    
            recognizer.setTranslation(CGPointMake(0.0, 0.0), inView: mainView)
            peripheralManager.updateValue(packetData, forCharacteristic: pointerCharacteristic, onSubscribedCentrals: nil)
        }
}
