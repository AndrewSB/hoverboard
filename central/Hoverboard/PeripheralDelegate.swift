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
            peripheral.discoverCharacteristics([pointerCharacteristicUUID, clickCharacteristicUUID], forService: service as CBService)
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
        var currentLocation = CGEventGetLocation(CGEventCreate(nil).takeRetainedValue())
        var formatter = NSNumberFormatter()
        var event: CGEventRef!
        var eventType: CGEventType!
        var mouseButton = CGMouseButton(kCGMouseButtonLeft) // This value is ignored
        
        switch characteristic.UUID {
        case pointerCharacteristicUUID:
            formatter.numberStyle = .DecimalStyle
            formatter.usesGroupingSeparator = false;
            formatter.maximumFractionDigits = 3
            formatter.minimumFractionDigits = 1
            
            var x = formatter.numberFromString(dataComponents[0] as String) as CGFloat
            var y = formatter.numberFromString(dataComponents[1] as String) as CGFloat
            var updatedLocation = CGPointMake((currentLocation.x + x), (currentLocation.y + y))
            
            eventType = CGEventType(kCGEventMouseMoved)
            event = CGEventCreateMouseEvent(nil, eventType, updatedLocation, mouseButton).takeRetainedValue()
            
            if floor(updatedLocation.x) >= maximumWidthAllowed {
                updatedLocation.x = maximumWidthAllowed!
            }
            
            if floor(updatedLocation.y) >= maximumHeightAllowed {
                updatedLocation.y = maximumHeightAllowed!
            }
            
            if floor(updatedLocation.x) <= 0 {
                updatedLocation.x = 0
            }
            
            
            if floor(updatedLocation.y) <= 0 {
                updatedLocation.y = 0
            }
            
            CGEventSetLocation(event, updatedLocation)
            CGEventPost(eventTap, event)
            
            break
        case clickCharacteristicUUID:
            var eventType = formatter.numberFromString(dataComponents[0] as String)!.intValue
            var clickState = formatter.numberFromString(dataComponents[1] as String)!.longLongValue
            var upEventType: Int32
            
            
            upEventType = eventType == NX_LMOUSEDOWN ? NX_LMOUSEUP : NX_RMOUSEUP
            event = CGEventCreateMouseEvent(nil, CGEventType(eventType), currentLocation, mouseButton).takeRetainedValue()
            
            CGEventSetIntegerValueField(event, CGEventField(kCGMouseEventClickState), clickState)
            CGEventPost(eventTap, event)
            CGEventSetType(event, CGEventType(upEventType))
            CGEventPost(eventTap, event)
            mouseEventNumber?++
            break
        default:
            return
        }
    }
}