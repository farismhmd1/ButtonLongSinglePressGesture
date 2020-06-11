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
    @IBOutlet weak var gestureButton: UIButton!
    var timer: Timer!
    var count: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gestureButton.addTarget(self, action: #selector(buttonDown(sender:)), for: .touchDown)
        gestureButton.addTarget(self, action: #selector(buttonUp(sender:)), for: [.touchUpInside, .touchUpOutside])
    }
    
    @objc func buttonDown(sender: AnyObject) {
//        singleFire()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(rapidFire), userInfo: nil, repeats: true)
    }
    
    @objc func buttonUp(sender: AnyObject) {
        timer.invalidate()
        
        // Less than 0.2, it will detect it as single tap
        if count < 0.2 {
            singleFire()
        } else {
            statusLabel.text = "long tap detected"
        }
        count = 0
        
    }
    
    func singleFire() {
        print("single tap detected")
        statusLabel.text = "single tap detected"
    }
    
    @objc func rapidFire() {
        count += 0.1
        let hours = Int(count) / 3600
        let minutes = Int(count) / 60 % 60
        let seconds = Int(count) % 60
        statusLabel.text = String(format: "%02i:%02i:%02i",hours,minutes,seconds)
    }
    
}
