//
//  AppDelegate.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/1/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import UIKit
import CoreBluetooth

let hoverboardLocalName = "Hoverboard"
let hoverboardServiceUUID = CBUUID(string: "06A3C2A4-1BC7-407A-B14B-3D629A6A428E")
let pointCharacteristicUUID = CBUUID(string: "F051A32C-C392-4549-8320-E3467E9AB107")
let clickCharacteristicUUID = CBUUID(string: "2FCDBC64-4DA2-4D01-AEE7-F040D08CCAA1")

var hoverboardService: CBMutableService!
var pointCharacteristic: CBMutableCharacteristic!
var clickCharacteristic: CBMutableCharacteristic!
var peripheralManager: CBPeripheralManager!
var peripheralManagerDelegate: PeripheralManagerDelegate!
var queuedData: [[CBMutableCharacteristic: NSData]]!
var eventCount: Int!
var mouse: Mouse!


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        queuedData = [[CBMutableCharacteristic: NSData]]()
        peripheralManagerDelegate = PeripheralManagerDelegate()
        peripheralManager = CBPeripheralManager(delegate: peripheralManagerDelegate, queue: nil)
        hoverboardService = CBMutableService(type: hoverboardServiceUUID, primary: true)
        pointCharacteristic = CBMutableCharacteristic(type: pointCharacteristicUUID, properties: .Notify, value: nil, permissions: .Readable)
        clickCharacteristic = CBMutableCharacteristic(type: clickCharacteristicUUID, properties: .Notify, value: nil, permissions: .Readable)
        hoverboardService.characteristics = [pointCharacteristic, clickCharacteristic]
        mouse = Mouse()
        eventCount = 0
                
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

