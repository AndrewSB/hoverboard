//
//  CentralManagerDelegate.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/2/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import CoreBluetooth

class CentralManagerDelegate: NSObject, CBCentralManagerDelegate {
    func centralManagerDidUpdateState(central: CBCentralManager!) {
        switch central.state {
        case CBCentralManagerState.PoweredOn:
            println("Powered On")
            println("Scanning for peripherals advertising the \(hoverboardServiceUUID.UUIDString) service")
            central.scanForPeripheralsWithServices([hoverboardServiceUUID], options: nil)
        case CBCentralManagerState.PoweredOff:
            println("Powered Off")
        case CBCentralManagerState.Resetting:
            println("Resetting")
        case CBCentralManagerState.Unauthorized:
            println("Unauthorized")
        case CBCentralManagerState.Unknown:
            println("Unknown")
        case CBCentralManagerState.Unsupported:
            println("Unsupported")
        }
    }
    
    func centralManager(central: CBCentralManager!, didDiscoverPeripheral peripheral: CBPeripheral!, advertisementData: [NSObject : AnyObject]!, RSSI: NSNumber!) {
        println("Discovered peripheral <\(peripheral.identifier.UUIDString)>")
        central.stopScan()
        println("Stopped scanning")
        println("Attempting to connect to peripheral <\(peripheral.identifier.UUIDString)>")
        central.connectPeripheral(peripheral, options: nil)
        connectedPeripherals.updateValue(peripheral, forKey: peripheral.identifier)
    }
    
    func centralManager(central: CBCentralManager!, didConnectPeripheral peripheral: CBPeripheral!) {
        peripheral.delegate = peripheralDelegate
        
        println("Connected to peripheral <\(peripheral.identifier.UUIDString)>")
        println("Attempting to discover services for peripheral <\(peripheral.identifier.UUIDString)>")
        peripheral.discoverServices([hoverboardServiceUUID])
    }
    
    func centralManager(central: CBCentralManager!, didDisconnectPeripheral peripheral: CBPeripheral!, error: NSError!) {
        if error != nil {
            println("Could not disconnect from peripheral \(peripheral.identifier.UUIDString)")
            println(error)
        }
        
        println("Disconnected from peripheral \(peripheral.identifier.UUIDString)")
        connectedPeripherals.removeValueForKey(peripheral.identifier)
        println("Scanning for peripherals advertising the \(hoverboardServiceUUID.UUIDString) service")
        central.scanForPeripheralsWithServices([hoverboardServiceUUID], options: nil)
    }
}