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
            println(error)
            return
        }
        
        for service in peripheral.services {
            println("Discovered service \(service.UUID.description) for peripheral <\(peripheral.identifier.UUIDString)>")
            peripheral.discoverCharacteristics([pointerCharacteristicUUID, clickCharacteristicUUID], forService: service as CBService)
        }
    }
}