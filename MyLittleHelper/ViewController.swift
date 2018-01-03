//
//  ViewController.swift
//  MyLittleHelper
//
//  Created by Torsten Schmickler on 12/12/2017.
//  Copyright © 2017 Mindtool. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var DayLabel: UILabel!
    
    // METHODS
    @IBAction func resetDayCount(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        let now = dateFormatter.string(from: Date())
        let defaults = UserDefaults.standard
        defaults.set(String(now), forKey: "LastResetKey")
        DayLabel.text = "0"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        let dateFormatter = DateFormatter()
        let today = Date()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        if let lastResetString = defaults.string(forKey: "LastResetKey") {
            print(lastResetString) // Some String Value
            let lastReset = dateFormatter.date(from: lastResetString)
            let differenceInDays = (today.timeIntervalSinceReferenceDate - lastReset!.timeIntervalSinceReferenceDate) / 86400
            DayLabel.text = String(format: "%.0f", differenceInDays.rounded(.up))
            print(differenceInDays)
        } else {
            let yesterday = Calendar.current.date(byAdding: .day, value: -23, to: Date())
            let yesterdayString = dateFormatter.string(from: yesterday!)
            defaults.set(String(yesterdayString), forKey: "LastResetKey")
            DayLabel.text = "N"
        }
    }
}

