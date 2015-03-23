//
//  HIDTarget.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/2/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import UIKit
import CoreGraphics
import Darwin

class HIDTarget: NSObject {
    var resetCoordinates = CGPointMake(0.0, 0.0)
    var dragEventNumber: Int!
    
    func point(recognizer: UIPanGestureRecognizer) {
        var translation = recognizer.translationInView(mainView)
        var velocity = recognizer.velocityInView(mainView)
        var velocityX = 1 as CGFloat //abs(velocity.x) / 500
        var velocityY = 1 as CGFloat //abs(velocity.y) / 500
        var x = translation.x * velocityX
        var y = translation.y * velocityY
        var location = CGPointMake(x, y)

        recognizer.setTranslation(resetCoordinates, inView: mainView)
        
        switch recognizer.state {
        case .Changed:
            switch dragWhilePointingGestureRecognizer.state {
            case .Changed:
                mouse.leftMouseDragged(location)
                
                break
            case .Began, .Ended, .Failed, .Cancelled:
                break
            case .Possible:
                mouse.mouseMoved(location)
                
                break
            }
        default:
            break
        }
    }

    func drag(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .Began:
            dragEventNumber = Int(arc4random())
            mouse.leftMouseDown(dragEventNumber)
            
            break
        case .Ended:
            mouse.leftMouseUp(dragEventNumber)
            
            break
        default:
            break
        }
    }
    
    func click(recognizer: UITapGestureRecognizer) {
        switch recognizer.state {
        case .Ended:
            var eventType = Mouse.EventTypes.LeftMouseDown
            var clickState = Mouse.ClickStates(rawValue: recognizer.numberOfTapsRequired)!

            mouse.click(eventType, clickState: clickState)
            
            break
        default:
            break
        }
        
    }
}
