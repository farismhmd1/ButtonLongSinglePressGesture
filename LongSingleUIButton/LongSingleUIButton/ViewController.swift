//
//  ViewController.swift
//  LongSingleUIButton
//
//  Created by Fari on 6/11/20.
//  Copyright © 2020 Faris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var gestureButton: GestureButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gestureButton.delegate = self
    }
    
}

extension ViewController: GestureButtonDelegate {
    
    func didSingleTapButton() {
        statusLabel.text = "single tap detected"
    }
    
    func didDoubleTapButton() {
        statusLabel.text = "double tap detected"
    }
    
    func didLongPressBeganButton() {
        statusLabel.text = "long press began"
    }
    
    func didLongPressRunning() {
        statusLabel.text = "long press running"
    }
    
    func didLongPressEndedButton() {
        statusLabel.text = "long press ended"
    }
    
}
