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

var point: Selector!
var click: Selector!
var drag: Selector!

var pointGestureRecognizer: UIPanGestureRecognizer!
var pointGestureRecognizerDelegate: PointGestureRecognizerDelegate!

var singleClickGestureRecognizer: UITapGestureRecognizer!

var singleClickWhilePointingGestureRecognizer: UITapGestureRecognizer!
var singleClickWhilePointingGestureRecognizerDelegate: ClickWhilePointingGestureRecognizerDelegate!

var doubleClickGestureRecognizer: UITapGestureRecognizer!

var doubleClickWhilePointingGestureRecognizer: UITapGestureRecognizer!
var doubleClickWhilePointingGestureRecognizerDelegate: ClickWhilePointingGestureRecognizerDelegate!

var tripleClickGestureRecognizer: UITapGestureRecognizer!

var tripleClickWhilePointingGestureRecognizer: UITapGestureRecognizer!
var tripleClickWhilePointingGestureRecognizerDelegate: ClickWhilePointingGestureRecognizerDelegate!

var dragWhilePointingGestureRecognizer: UIPanGestureRecognizer!
var dragWhilePointingGestureRecognizerDelegate: DragWhilePointingGestureRecognizerDelegate!

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = self.view
        
        point = Selector("point:")
        click = Selector("click:")
        drag = Selector("drag:")
        
        pointGestureRecognizerDelegate = PointGestureRecognizerDelegate()
        pointGestureRecognizer = UIPanGestureRecognizer(target: hid, action: point)
        pointGestureRecognizer.minimumNumberOfTouches = 2
        pointGestureRecognizer.maximumNumberOfTouches = 2
        pointGestureRecognizer.delegate = pointGestureRecognizerDelegate
        
        singleClickGestureRecognizer = UITapGestureRecognizer(target: hid, action: click)
        singleClickGestureRecognizer.numberOfTouchesRequired = 2
        singleClickGestureRecognizer.numberOfTapsRequired = 1

        singleClickWhilePointingGestureRecognizerDelegate = ClickWhilePointingGestureRecognizerDelegate()
        singleClickWhilePointingGestureRecognizer = UITapGestureRecognizer(target: hid, action: click)
        singleClickWhilePointingGestureRecognizer.numberOfTouchesRequired = 1
        singleClickWhilePointingGestureRecognizer.numberOfTapsRequired = 1
        singleClickWhilePointingGestureRecognizer.delegate = singleClickWhilePointingGestureRecognizerDelegate

        doubleClickGestureRecognizer = UITapGestureRecognizer(target: hid, action: click)
        doubleClickGestureRecognizer.numberOfTouchesRequired = 2
        doubleClickGestureRecognizer.numberOfTapsRequired = 2
        
        doubleClickWhilePointingGestureRecognizerDelegate = ClickWhilePointingGestureRecognizerDelegate()
        doubleClickWhilePointingGestureRecognizer = UITapGestureRecognizer(target: hid, action: click)
        doubleClickWhilePointingGestureRecognizer.numberOfTouchesRequired = 1
        doubleClickWhilePointingGestureRecognizer.numberOfTapsRequired = 2
        doubleClickWhilePointingGestureRecognizer.delegate = doubleClickWhilePointingGestureRecognizerDelegate

        tripleClickGestureRecognizer = UITapGestureRecognizer(target: hid, action: click)
        tripleClickGestureRecognizer.numberOfTouchesRequired = 2
        tripleClickGestureRecognizer.numberOfTapsRequired = 3
        
        tripleClickWhilePointingGestureRecognizerDelegate = ClickWhilePointingGestureRecognizerDelegate()
        tripleClickWhilePointingGestureRecognizer = UITapGestureRecognizer(target: hid, action: click)
        tripleClickWhilePointingGestureRecognizer.numberOfTouchesRequired = 1
        tripleClickWhilePointingGestureRecognizer.numberOfTapsRequired = 3
        tripleClickWhilePointingGestureRecognizer.delegate = tripleClickWhilePointingGestureRecognizerDelegate
        
        dragWhilePointingGestureRecognizerDelegate = DragWhilePointingGestureRecognizerDelegate()
        dragWhilePointingGestureRecognizer = UIPanGestureRecognizer(target: hid, action: drag)
        dragWhilePointingGestureRecognizer.minimumNumberOfTouches = 1
        dragWhilePointingGestureRecognizer.maximumNumberOfTouches = 1
        dragWhilePointingGestureRecognizer.delegate = dragWhilePointingGestureRecognizerDelegate
        
        self.view.addGestureRecognizer(pointGestureRecognizer)
        self.view.addGestureRecognizer(singleClickGestureRecognizer)
        self.view.addGestureRecognizer(singleClickWhilePointingGestureRecognizer)
        self.view.addGestureRecognizer(doubleClickGestureRecognizer)
        self.view.addGestureRecognizer(doubleClickWhilePointingGestureRecognizer)
        self.view.addGestureRecognizer(tripleClickGestureRecognizer)
        self.view.addGestureRecognizer(tripleClickWhilePointingGestureRecognizer)
        self.view.addGestureRecognizer(dragWhilePointingGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

