//
//  Mouse.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/21/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import UIKit
import CoreGraphics
import CoreBluetooth

class Mouse: NSObject {
    enum EventTypes: Int {
        case Null = 0, LeftMouseDown, LeftMouseUp, RightMouseDown, RightMouseUp, MouseMoved, LeftMouseDragged, RightMouseDragged
    }
    
    enum ClickStates: Int {
        case Null = 0, Single, Double, Triple
    }
    
    func mouseMoved(eventLocation: CGPoint!) {
        update(pointCharacteristic, eventType: EventTypes.MouseMoved, eventLocation: eventLocation, eventNumber: 0, clickState: ClickStates.Null)
    }
    
    func leftMouseDown(eventNumber: Int!) {
        update(pointCharacteristic, eventType: EventTypes.LeftMouseDown, eventLocation: CGPointMake(0.0, 0.0), eventNumber: eventNumber, clickState: ClickStates.Null)
    }
    
    func leftMouseUp(eventNumber: Int!) {
        update(pointCharacteristic, eventType: EventTypes.LeftMouseUp, eventLocation: CGPointMake(0.0, 0.0), eventNumber: eventNumber, clickState: ClickStates.Null)
    }
    
    func leftMouseDragged(eventLocation: CGPoint!) {
        update(pointCharacteristic, eventType: EventTypes.LeftMouseDragged, eventLocation: eventLocation, eventNumber: 0, clickState: ClickStates.Null)
    }
    
    func click(eventType: EventTypes, clickState: ClickStates) {
        update(clickCharacteristic, eventType: eventType, eventLocation: CGPointMake(0.0, 0.0), eventNumber: 0, clickState: clickState)
    }
    
    func update(characteristic: CBMutableCharacteristic, eventType: EventTypes!, eventLocation: CGPoint!, eventNumber: Int!, clickState: ClickStates!) {
        var packetString: NSString!

        numberFormatter.numberStyle = .DecimalStyle
        numberFormatter.usesGroupingSeparator = false
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 1
        
        var stringX = numberFormatter.stringFromNumber(eventLocation.x)!
        var stringY = numberFormatter.stringFromNumber(eventLocation.y)!
        
        switch characteristic {
        case pointCharacteristic:
            packetString = "\(eventType.rawValue),\(eventNumber),\(stringX),\(stringY)"
        case clickCharacteristic:
            packetString = "\(eventType.rawValue),\(clickState.rawValue)"
        default:
            return
        }
        
        NSLog(packetString)
        
        var packetData = packetString.dataUsingEncoding(NSUTF8StringEncoding)!
        var didSend = peripheralManager.updateValue(packetData, forCharacteristic: characteristic, onSubscribedCentrals: nil)
        
        if didSend == false {
            queuedUpdates.append([characteristic: packetData])
        }
    }
}