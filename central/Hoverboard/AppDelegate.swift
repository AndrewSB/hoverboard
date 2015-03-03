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

let hoverboardServiceUUID = CBUUID(string: "C51216A6-5469-48B5-A173-B7B8FCE5AC16")
let pointerCharacteristicUUID = CBUUID(string: "885DC193-4F99-4B17-9C7A-706763DC35FA")
let clickCharacteristicUUID = CBUUID(string: "D8A35232-0C63-4775-ACD2-0FE683CF85BE")
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
var mouseEventNumber: UInt8!

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

