//
//  WindowTimer.swift
//  WindowTimer
//
//  Created by Daniel Eke on 20.5.2020.
//  Copyright © 2020 Daniel Eke. All rights reserved.
//

import UIKit

class WindowTimer {
    
    static var targetDate: Date? {
        didSet {
            updateView()
        }
    }
    
    // Automaticaly clear the timer after specified seconds
    static var clearAfter: Int = 15
    
    private static let activeWindow = UIApplication.shared.windows.last
    private static var timerLabel: UILabel = {
        let timerLabel = UILabel()
        timerLabel.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        timerLabel.textColor = .white
        timerLabel.font = timerLabel.font.withSize(10.0)
        timerLabel.isUserInteractionEnabled = false
        return timerLabel
    }()
    private static var timer: Timer?
    
    private static func updateView() {
        guard let window = activeWindow else {
            print("WindowTimer - No active window found")
            return
        }
        guard targetDate != nil else {
            timer?.invalidate()
            timer = nil
            timerLabel.removeFromSuperview()
            return
        }
                
        if timerLabel.superview == nil {
            window.addSubview(timerLabel)
            timerLabel.translatesAutoresizingMaskIntoConstraints = false
            timerLabel.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
            timerLabel.topAnchor.constraint(equalTo: window.topAnchor, constant: 64).isActive = true
        }
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerTick), userInfo: nil, repeats: true)
    }
    
    @objc private static func timerTick() {
        guard let target = targetDate?.timeIntervalSince1970 else { return }
        // Need to bring to front in case the window content was modified
        timerLabel.superview?.bringSubviewToFront(timerLabel)
        
        let now = Date().timeIntervalSince1970
        let secondsDiff = Int(target) - Int(now)
        if secondsDiff < 0 {
            let inverted = abs(secondsDiff)
            timerLabel.text = "Done \(inverted)"
            if inverted > clearAfter {
                targetDate = nil
            }
        } else{
            let hours = (secondsDiff / 3600)
            let minutes = (secondsDiff % 3600) / 60
            let seconds = (secondsDiff % 3600) % 60
            timerLabel.text = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        }
    }
    
}
