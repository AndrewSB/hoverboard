//
//  PeripheralDelegate.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/2/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import CoreBluetooth

class PeripheralDelegate: NSObject, CBPeripheralDelegate {
    func peripheral(peripheral: CBPeripheral!, didDiscoverServices error: NSError!) {
        if error != nil {
            println("Unable to discover services for peripheral \(peripheral.identifier.UUIDString)")
            println(error)
            return
        }
        
        for service in peripheral.services {
            println("Discovered service \(service.UUID.description) for peripheral <\(peripheral.identifier.UUIDString)>")
            peripheral.discoverCharacteristics([pointCharacteristicUUID, clickCharacteristicUUID], forService: service as CBService)
        }
    }
    
    func peripheral(peripheral: CBPeripheral!, didDiscoverCharacteristicsForService service: CBService!, error: NSError!) {
        if error != nil {
            println(error)
            return
        }
        
        for characteristic in service.characteristics {
            println("Discovered characteristic \(characteristic.UUID.description) of service <\(service.UUID.UUIDString)> from peripheral \(peripheral.identifier.UUIDString)")
            println("Attempting to subscribe to notifications for characterstic \(characteristic.UUID.description) of service <\(service.UUID.UUIDString)> from peripheral \(peripheral.identifier.UUIDString)")
            peripheral.setNotifyValue(true, forCharacteristic: characteristic as CBCharacteristic)
        }
    }
    
    func peripheral(peripheral: CBPeripheral!, didUpdateNotificationStateForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        if error != nil {
            println("Could not receive update of notification state for \(characteristic.UUID.description) of service <\(hoverboardServiceUUID)> from peripheral \(peripheral.identifier.UUIDString)")
            println(error)
            return
        }
        
        if characteristic.isNotifying != true {
            println("Characteristic \(characteristic.UUID.description) of service <\(hoverboardServiceUUID)> from peripheral \(peripheral.identifier.UUIDString) is no longer notifying")
            println("Attempting to cancel connection with peripheral \(peripheral.identifier.UUIDString)")
            centralManager.cancelPeripheralConnection(peripheral)
            return
        }
        
        println("Characteristic \(characteristic.UUID.description) of service <\(hoverboardServiceUUID)> from peripheral \(peripheral.identifier.UUIDString) is notifying")
    }
    
    func peripheral(peripheral: CBPeripheral!, didUpdateValueForCharacteristic characteristic: CBCharacteristic!, error: NSError!) {
        var data = NSMutableString(data: characteristic.value(), encoding: NSUTF8StringEncoding)!
        var dataComponents = data.componentsSeparatedByString(",")
        var formatter = NSNumberFormatter()
        
        formatter.numberStyle = .DecimalStyle
        formatter.usesGroupingSeparator = false;
        formatter.maximumFractionDigits = 3
        formatter.minimumFractionDigits = 1
        
        var event = CGEventCreate(nil).takeRetainedValue()
        var currentLocation = CGEventGetLocation(event)
        var eventType = CGEventType(formatter.numberFromString(dataComponents[0] as String)!.intValue)

        CGEventSetType(event, eventType)

//        switch characteristic.UUID {
//        case pointCharacteristicUUID:
            var eventNumber = formatter.numberFromString(dataComponents[1] as String)!.longLongValue
            var x = formatter.numberFromString(dataComponents[2] as String)! as CGFloat
            var y = formatter.numberFromString(dataComponents[3] as String)! as CGFloat
            var threshold = 0.0001 as CGFloat
            
//            if abs(x) < threshold {
//                x = x.isSignMinus ? -threshold : threshold
//            }
//            
//            if abs(y) < threshold {
//                y = y.isSignMinus ? -threshold : threshold
//            }
            
            var location = CGPointMake(currentLocation.x + x, currentLocation.y + y)
            
            if floor(location.x) >= maximumWidthAllowed {
                location.x = maximumWidthAllowed!
            }
            
            if floor(location.y) >= maximumHeightAllowed {
                location.y = maximumHeightAllowed!
            }
            
            if floor(location.x) <= 0 {
                location.x = 0
            }
            
            if floor(location.y) <= 0 {
                location.y = 0
            }
            
            CGEventSetLocation(event, location)
            CGEventSetIntegerValueField(event, CGEventField(kCGMouseEventNumber), eventNumber)
            CGEventPost(eventTap, event)
//        case clickCharacteristicUUID:
//            var clickState = formatter.numberFromString(dataComponents[1] as String)!.longLongValue
//            var upEventType = eventType == kCGEventLeftMouseDown ? kCGEventLeftMouseUp : kCGEventRightMouseUp
//            var eventNumber = Int64(arc4random())
//            var upEvent = CGEventCreateCopy(event).takeRetainedValue()
//            
//            CGEventSetIntegerValueField(event, CGEventField(kCGMouseEventClickState), clickState)
//            CGEventSetIntegerValueField(event, CGEventField(kCGMouseEventNumber), eventNumber)
//            CGEventPost(eventTap, event)
//            CGEventSetType(upEvent, upEventType)
//            CGEventPost(eventTap, upEvent)
//        default:
//            return
//        }
    }
}