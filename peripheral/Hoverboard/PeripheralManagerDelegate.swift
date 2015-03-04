//
//  PeripheralManagerDelegate.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/2/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import CoreBluetooth

class PeripheralManagerDelegate: NSObject, CBPeripheralManagerDelegate {
    func peripheralManagerDidUpdateState(peripheral: CBPeripheralManager!) {
        switch peripheral.state {
        case CBPeripheralManagerState.PoweredOn:
            println("Powered On")
            println("Adding service with UUID: \(hoverboardServiceUUID)")
            peripheral.addService(hoverboardService)
            println("Attempting to advertise service with UUID: \(hoverboardServiceUUID)")
            peripheral.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [hoverboardServiceUUID], CBAdvertisementDataLocalNameKey: hoverboardLocalName])
        case CBPeripheralManagerState.PoweredOff:
            println("Powered Off")
        case CBPeripheralManagerState.Resetting:
            println("Resetting")
        case CBPeripheralManagerState.Unauthorized:
            println("Unauthorized")
        case CBPeripheralManagerState.Unsupported:
            println("Unsupported")
        case CBPeripheralManagerState.Unknown:
            println("Unknown")
        default:
            break
        }
    }
    
    func peripheralManagerDidStartAdvertising(peripheral: CBPeripheralManager!, error: NSError!) {
        if error != nil {
            println("Failed to adverstise service with UUID: \(hoverboardServiceUUID)")
            println(error)
        }
        
        println("Started adverstising service with UUID: \(hoverboardServiceUUID)")
    }
    
    func peripheralManagerIsReadyToUpdateSubscribers(peripheral: CBPeripheralManager!) {
        for (index, data) in enumerate(queuedData) {
            for (characteristic, value) in data {
                var didSend = false
                
                while didSend == false {
                    didSend = peripheralManager.updateValue(value, forCharacteristic: characteristic, onSubscribedCentrals: nil)
                }
            }
        }
    }
}