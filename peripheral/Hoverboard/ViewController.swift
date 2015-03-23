//
//  ViewController.swift
//  Hoverboard
//
//  Created by Zachary Adam Kaplan on 3/1/15.
//  Copyright (c) 2015 viralkitty. All rights reserved.
//

import UIKit
import CoreBluetooth

var mainView: UIView!

var hidTarget: HIDTarget!

var point: Selector!
var click: Selector!
var drag: Selector!

var pointGestureRecognizer: UIPanGestureRecognizer!
var pointGestureRecognizerDelegate: PointGestureRecognizerDelegate!
var pointGestureRecognizerHIDTarget: HIDTarget!

var singleClickGestureRecognizer: UITapGestureRecognizer!
var singleClickGestureRecognizerDelegate: SingleClickGestureRecognizerDelegate!
var singleClickGestureRecognizerHIDTarget: HIDTarget!

var singleClickWhilePointingGestureRecognizer: UITapGestureRecognizer!
var singleClickWhilePointingGestureRecognizerDelegate: ClickWhilePointingGestureRecognizerDelegate!
var singleClickWhilePointingGestureRecognizerHIDTarget: HIDTarget!

var doubleClickGestureRecognizer: UITapGestureRecognizer!
var doubleClickGestureRecognizerDelegate: DoubleClickGestureRecognizerDelegate!
var doubleClickGestureRecognizerHIDTarget: HIDTarget!

var doubleClickWhilePointingGestureRecognizer: UITapGestureRecognizer!
var doubleClickWhilePointingGestureRecognizerDelegate: ClickWhilePointingGestureRecognizerDelegate!
var doubleClickWhilePointingGestureRecognizerHIDTarget: HIDTarget!

var tripleClickGestureRecognizer: UITapGestureRecognizer!
var tripleClickGestureRecognizerDelegate: TripleClickGestureRecognizerDelegate!
var tripleClickGestureRecognizerHIDTarget: HIDTarget!

var tripleClickWhilePointingGestureRecognizer: UITapGestureRecognizer!
var tripleClickWhilePointingGestureRecognizerDelegate: ClickWhilePointingGestureRecognizerDelegate!
var tripleClickWhilePointingGestureRecognizerHIDTarget: HIDTarget!

var dragWhilePointingGestureRecognizer: UIPanGestureRecognizer!
var dragWhilePointingGestureRecognizerDelegate: DragWhilePointingGestureRecognizerDelegate!
var dragWhilePointingGestureRecognizerHIDTarget: HIDTarget!

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = self.view
        
        point = Selector("point:")
        click = Selector("click:")
        drag = Selector("drag:")
        
        pointGestureRecognizerDelegate = PointGestureRecognizerDelegate()
        pointGestureRecognizerHIDTarget = HIDTarget()
        pointGestureRecognizer = UIPanGestureRecognizer(target: pointGestureRecognizerHIDTarget, action: point)
        pointGestureRecognizer.minimumNumberOfTouches = 2
        pointGestureRecognizer.maximumNumberOfTouches = 2
        pointGestureRecognizer.delegate = pointGestureRecognizerDelegate
        
        singleClickGestureRecognizerDelegate = SingleClickGestureRecognizerDelegate()
        singleClickGestureRecognizerHIDTarget = HIDTarget()
        singleClickGestureRecognizer = UITapGestureRecognizer(target: singleClickGestureRecognizerHIDTarget, action: click)
        singleClickGestureRecognizer.numberOfTouchesRequired = 2
        singleClickGestureRecognizer.numberOfTapsRequired = 1
        singleClickGestureRecognizer.delegate = singleClickGestureRecognizerDelegate

        singleClickWhilePointingGestureRecognizerDelegate = ClickWhilePointingGestureRecognizerDelegate()
        singleClickWhilePointingGestureRecognizerHIDTarget = HIDTarget()
        singleClickWhilePointingGestureRecognizer = UITapGestureRecognizer(target: singleClickWhilePointingGestureRecognizerHIDTarget, action: click)
        singleClickWhilePointingGestureRecognizer.numberOfTouchesRequired = 1
        singleClickWhilePointingGestureRecognizer.numberOfTapsRequired = 1
        singleClickWhilePointingGestureRecognizer.delegate = singleClickWhilePointingGestureRecognizerDelegate

        doubleClickGestureRecognizerDelegate = DoubleClickGestureRecognizerDelegate()
        doubleClickGestureRecognizerHIDTarget = HIDTarget()
        doubleClickGestureRecognizer = UITapGestureRecognizer(target: doubleClickGestureRecognizerHIDTarget, action: click)
        doubleClickGestureRecognizer.numberOfTouchesRequired = 2
        doubleClickGestureRecognizer.numberOfTapsRequired = 2
        doubleClickGestureRecognizer.delegate = doubleClickGestureRecognizerDelegate
        
        doubleClickWhilePointingGestureRecognizerDelegate = ClickWhilePointingGestureRecognizerDelegate()
        doubleClickWhilePointingGestureRecognizerHIDTarget = HIDTarget()
        doubleClickWhilePointingGestureRecognizer = UITapGestureRecognizer(target: doubleClickWhilePointingGestureRecognizerHIDTarget, action: click)
        doubleClickWhilePointingGestureRecognizer.numberOfTouchesRequired = 1
        doubleClickWhilePointingGestureRecognizer.numberOfTapsRequired = 2
        doubleClickWhilePointingGestureRecognizer.delegate = doubleClickWhilePointingGestureRecognizerDelegate

        tripleClickGestureRecognizerDelegate = TripleClickGestureRecognizerDelegate()
        tripleClickGestureRecognizerHIDTarget = HIDTarget()
        tripleClickGestureRecognizer = UITapGestureRecognizer(target: tripleClickGestureRecognizerHIDTarget, action: click)
        tripleClickGestureRecognizer.numberOfTouchesRequired = 2
        tripleClickGestureRecognizer.numberOfTapsRequired = 3
        tripleClickGestureRecognizer.delegate = tripleClickGestureRecognizerDelegate
        
        tripleClickWhilePointingGestureRecognizerDelegate = ClickWhilePointingGestureRecognizerDelegate()
        tripleClickWhilePointingGestureRecognizerHIDTarget = HIDTarget()
        tripleClickWhilePointingGestureRecognizer = UITapGestureRecognizer(target: tripleClickWhilePointingGestureRecognizerHIDTarget, action: click)
        tripleClickWhilePointingGestureRecognizer.numberOfTouchesRequired = 1
        tripleClickWhilePointingGestureRecognizer.numberOfTapsRequired = 3
        tripleClickWhilePointingGestureRecognizer.delegate = tripleClickWhilePointingGestureRecognizerDelegate
        
        dragWhilePointingGestureRecognizerDelegate = DragWhilePointingGestureRecognizerDelegate()
        dragWhilePointingGestureRecognizerHIDTarget = HIDTarget()
        dragWhilePointingGestureRecognizer = UIPanGestureRecognizer(target: dragWhilePointingGestureRecognizerHIDTarget, action: drag)
        dragWhilePointingGestureRecognizer.minimumNumberOfTouches = 1
        dragWhilePointingGestureRecognizer.maximumNumberOfTouches = 1
        dragWhilePointingGestureRecognizer.delegate = dragWhilePointingGestureRecognizerDelegate
        
        self.view.addGestureRecognizer(pointGestureRecognizer)
//        self.view.addGestureRecognizer(singleClickGestureRecognizer)
//        self.view.addGestureRecognizer(singleClickWhilePointingGestureRecognizer)
//        self.view.addGestureRecognizer(doubleClickGestureRecognizer)
//        self.view.addGestureRecognizer(doubleClickWhilePointingGestureRecognizer)
//        self.view.addGestureRecognizer(tripleClickGestureRecognizer)
//        self.view.addGestureRecognizer(tripleClickWhilePointingGestureRecognizer)
//        self.view.addGestureRecognizer(dragWhilePointingGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

