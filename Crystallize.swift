//
//  Crystallize.swift
//  improcessor
//
//  Created by student on 11.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import UIKit

class Crystallize : FilterDelegate {
    var set : settings
    let fName : String
    
    init() {
        self.fName = "CICrystallize"
        //set = settings(allSetting: ["inputRadius": (0.0, 30.0), "inputCenter" : (0, 300)])
        set = settings(allSetting: ["inputRadius": (10.0 as NSNumber, 30.0 as NSNumber, 20.0 as NSNumber), "inputCenter" : (CIVector(x: 100), CIVector(x: 200), CIVector(x: 150)) ])
    }
    
    func getFilterName() -> String {
        return fName
    }
    
    func getSetting() -> settings {
        return set
    }
    
    func  getCintrols(width w: Int) -> [UIView]? {
        var res : [UIView] = []
        let label1 = UILabel()
        label1.text = "inputRadius"
        let us1 = UISlider(frame: CGRect(x: 0, y: 10, width: w, height: 10))
        let v1 = set.set["inputRadius"]
        us1.minimumValue = v1?.0 as! Float
        us1.maximumValue = v1?.1 as! Float
        us1.value = v1?.2 as! Float
        us1.accessibilityValue = "1"
        res.insert(label1, at: res.count)
        res.insert(us1, at: res.count)
        
        
        let label2 = UILabel()
        label2.text = "inputCenter"
        let us2 = UISlider(frame: CGRect(x: 0, y: 10, width: w, height: 10))
        let v2 = set.set["inputCenter"]
        us2.minimumValue = Float((v2?.0 as! CIVector).x)
        us2.maximumValue = Float((v2?.1 as! CIVector).x)
        us2.value = Float((v2?.2 as! CIVector).x)
        us2.accessibilityValue = "2"
        res.insert(label2, at: res.count)
        res.insert(us2, at: res.count)
        
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
        return UIColor.init(colorLiteralRed: 0.7, green: 0.6, blue: 0.2, alpha: 1.0)
    }
    
    func setValue(values v : [UIView]) {
        for k in v {
            if let t = k as? UISlider {
            if t.accessibilityValue == "1" {
                set.set["inputRadius"]?.2 = t.value as NSNumber

            }
            if t.accessibilityValue == "2" {
                set.set["inputCenter"]?.2 = CIVector(x: CGFloat(t.value))
                
            }
        }
        }
        
    }
}
