//
//  CISharpenLuminance .swift
//  improcessor
//
//  Created by student on 12.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import UIKit

class CISharpenLuminance : FilterDelegate {
    var set : settings
    let fName : String
    
    init() {
        self.fName = "CISharpenLuminance"
        set = settings(allSetting: ["inputSharpness": (0.0 as NSNumber, 1.0 as NSNumber, 0.40 as NSNumber)])
    }
    
    func getFilterName() -> String {
        return fName
    }
    
    func getSetting() -> settings {
        return set
    }
    
    func  getCintrols(width w: Int) -> [UIView]? {
        var res : [UIView] = []
        for (key, value) in set.set {
            let label = UILabel()
            label.text = key
            let us = UISlider(frame: CGRect(x: 0, y: 10, width: w, height: 10))
            us.minimumValue = value.0 as! Float
            us.maximumValue = value.1 as! Float
            us.value = value.2 as! Float
            us.accessibilityValue = "1"
            res.insert(label, at: res.count)
            res.insert(us, at: res.count)
        }
        return res
    }
    
    func getResultSetting() -> [String : Any] {
        var res : [String : Any] = [:]
        for (key, value) in set.set {
            res[key] = value.2
        }
        
        return res
    }
    
    func  getColor() -> UIColor {
        return UIColor.init(colorLiteralRed: 0.9, green: 0.3, blue: 0.4, alpha: 1.0)
    }
    
    func setValue(values v : [UIView]) {
        for k in v {
            if let t = k as? UISlider {
                if t.accessibilityValue == "1" {
                    set.set["inputSharpness"]?.2 = t.value as NSNumber
                    
                }
            }
        }
    }
}
