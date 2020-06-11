//
//  Gesture Button.swift
//  LongSingleUIButton
//
//  Created by Fari on 6/11/20.
//  Copyright © 2020 Faris. All rights reserved.
//

import UIKit

protocol GestureButtonDelegate: class {
    func didSingleTapButton()
    func didDoubleTapButton()
    func didLongPressBeganButton()
    func didLongPressEndedButton()
}
class GestureButton: UIButton {
    
    weak var delegate: GestureButtonDelegate?
    var timer: Timer!
    var count: Double = 0
    var singleTapCount = 0
    var duration: String = ""
    
    // Programatically initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    // UI Initialization
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        // UI Changes if any
    }
    
    func setup() {
        self.addTarget(self, action: #selector(buttonDown(sender:)), for: .touchDown)
        self.addTarget(self, action: #selector(buttonUp(sender:)), for: [.touchUpInside, .touchUpOutside])
    }
    
    
    // MARK: - Button Actions
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
            singleTapCount += 1
            if singleTapCount == 1 {
                DispatchQueue.main.asyncAfter(deadline: .now() + (count + 0.1) * 2) {
                    
                    if self.singleTapCount == 1 {
                        self.singleTap()
                    } else {
                        self.doubleTap()
                    }
                    self.singleTapCount = 0
                }
            }
        } else {
            self.longPressEnded()
        }
        count = 0
        
    }
    
    
    func singleTap() {
        self.delegate?.didSingleTapButton()
        print("single tap detected")
    }
    
    func doubleTap() {
        self.delegate?.didDoubleTapButton()
        print("double tap detected")
    }
    
    func longPressBegan() {
        self.delegate?.didLongPressBeganButton()
        print("long press began")
    }
    
    func longPressEnded() {
        self.delegate?.didLongPressEndedButton()
        print("long press ended")
    }
    
    @objc func rapidFire() {
        count += 0.1
        let hours = Int(count) / 3600
        let minutes = Int(count) / 60 % 60
        let seconds = Int(count) % 60
        duration = String(format: "%02i:%02i:%02i",hours,minutes,seconds)
        if count == 0.2 {
            self.longPressBegan()
        }
    }
    
}
