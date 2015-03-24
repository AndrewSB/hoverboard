//
//  AppDelegate.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/1/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import Cocoa
import CoreBluetooth
import CoreGraphics

let hoverboardServiceUUID = CBUUID(string: "06A3C2A4-1BC7-407A-B14B-3D629A6A428E")
let pointCharacteristicUUID = CBUUID(string: "F051A32C-C392-4549-8320-E3467E9AB107")
let clickCharacteristicUUID = CBUUID(string: "2FCDBC64-4DA2-4D01-AEE7-F040D08CCAA1")
let eventTap = CGEventTapLocation(kCGHIDEventTap)
let screenHeightPadding: CGFloat = 0.004
let screenWidthPadding: CGFloat = 0.004
let statusItemLength: CGFloat = 90

var peripheralDelegate: CBPeripheralDelegate!
var centralManager: CBCentralManager!
var centralManagerDelegate: CentralManagerDelegate!
var statusBar: NSStatusBar!
var statusItem: NSStatusItem!
var connectedPeripherals: [NSUUID: CBPeripheral]!
var screen: NSScreen!
var maximumHeightAllowed: CGFloat!
var maximumWidthAllowed: CGFloat!
var mouseEventNumber: Int64!

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        peripheralDelegate = PeripheralDelegate()
        centralManagerDelegate = CentralManagerDelegate()
        mouseEventNumber = 1
        connectedPeripherals = [NSUUID: CBPeripheral]()
        screen = NSScreen.mainScreen()
        maximumHeightAllowed = screen.frame.height - screenHeightPadding
        maximumWidthAllowed = screen.frame.width - screenWidthPadding
        centralManager = CBCentralManager(delegate: centralManagerDelegate, queue: nil)
        statusBar = NSStatusBar.systemStatusBar()
        statusItem = statusBar.statusItemWithLength(statusItemLength)
        statusItem.title = "Hoverboard"
        statusItem.menu = NSMenu(title: "Foo")
        
        statusItem.menu!.addItemWithTitle("Hello", action: nil, keyEquivalent: "")

    }

    func applicationWillTerminate(aNotification: NSNotification) {
    }
}

