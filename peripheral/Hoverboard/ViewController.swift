//
//  ViewController.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/1/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import UIKit
import CoreBluetooth

var hidTarget: HIDTarget!
var pointGestureRecognizer: UIPanGestureRecognizer!
var pointGestureRecognizerDelegate: PointGestureRecognizerDelegate!
var clickWhilePointingGestureRecognizer: UITapGestureRecognizer!
var clickGestureRecognizerDelegate: ClickGestureRecognizerDelegate!
var clickGestureRecognizer: UITapGestureRecognizer!
var doubleClickGestureRecognizerDelegate: DoubleClickGestureRecognizerDelegate!
var doubleClickGestureRecognizer: UITapGestureRecognizer!
var doubleClickWhilePointingGestureRecognizer: UITapGestureRecognizer!
var dragWhilePointingGestureRecognizer: UIPanGestureRecognizer!
var keyGestureRecognizer: UITapGestureRecognizer!
var mainView: UIView!

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hidTarget = HIDTarget()
        mainView = self.view
        pointGestureRecognizerDelegate = PointGestureRecognizerDelegate()
        pointGestureRecognizer = UIPanGestureRecognizer(target: hidTarget, action: Selector("point:"))
        pointGestureRecognizer.minimumNumberOfTouches = 2
        pointGestureRecognizer.maximumNumberOfTouches = 2
        pointGestureRecognizer.delegate = pointGestureRecognizerDelegate
        clickGestureRecognizerDelegate = ClickGestureRecognizerDelegate()
        clickGestureRecognizer = UITapGestureRecognizer(target: hidTarget, action: Selector("click:"))
        clickGestureRecognizer.numberOfTouchesRequired = 2
        clickGestureRecognizer.numberOfTapsRequired = 1
        clickGestureRecognizer.delegate = clickGestureRecognizerDelegate
        doubleClickGestureRecognizerDelegate = DoubleClickGestureRecognizerDelegate()
        doubleClickGestureRecognizer = UITapGestureRecognizer(target: hidTarget, action: Selector("doubleClick:"))
        doubleClickGestureRecognizer.numberOfTouchesRequired = 2
        doubleClickGestureRecognizer.numberOfTapsRequired = 2
        doubleClickGestureRecognizer.delegate = doubleClickGestureRecognizerDelegate

    
        
//        clickWhilePointingGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("click:"))
//        clickWhilePointingGestureRecognizer.numberOfTouchesRequired = 1
//        clickWhilePointingGestureRecognizer.numberOfTapsRequired = 1
//        clickWhilePointingGestureRecognizer.delegate = self
        
//        doubleClickWhilePointingGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("doubleClick:"))
//        doubleClickWhilePointingGestureRecognizer.numberOfTapsRequired = 2
//        doubleClickWhilePointingGestureRecognizer.numberOfTouchesRequired = 1
//        doubleClickWhilePointingGestureRecognizer.delegate = self
//        keyGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("key:"))
//        keyGestureRecognizer.numberOfTouchesRequired = 1
//        keyGestureRecognizer.numberOfTapsRequired = 1
//        keyGestureRecognizer.delegate = self
//        dragWhilePointingGestureRecognizer = UIPanGestureRecognizer(target: self, action: "drag:")
//        dragWhilePointingGestureRecognizer.minimumNumberOfTouches = 1
//        dragWhilePointingGestureRecognizer.maximumNumberOfTouches = 1
//        dragWhilePointingGestureRecognizer.delegate = self
       
        self.view.addGestureRecognizer(pointGestureRecognizer)
        self.view.addGestureRecognizer(clickGestureRecognizer)
        self.view.addGestureRecognizer(doubleClickGestureRecognizer)
//        self.view.addGestureRecognizer(clickWhilePointingGestureRecognizer)
//        self.view.addGestureRecognizer(keyGestureRecognizer)
//        self.view.addGestureRecognizer(doubleClickWhilePointingGestureRecognizer)
//        self.view.addGestureRecognizer(dragWhilePointingGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

