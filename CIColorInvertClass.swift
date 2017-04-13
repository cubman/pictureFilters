//
//  CIColorInvertClass.swift
//  improcessor
//
//  Created by student on 30.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import UIKit

class CIColorInvertClass : FilterDelegate {
    var set : settings
    let fName : String
    
    init() {
        self.fName = "CIColorInvert"
        set = settings(allSetting: [:])
    }
    
    func getFilterName() -> String {
        return fName
    }
    
    func getSetting() -> settings {
        return set
    }
    
    func  getCintrols(width w: Int) -> [UIView]? {
        return nil
    }
    
    func getResultSetting() -> [String : Any] {
        return [:]
    }
    
    func  getColor() -> UIColor {
        return UIColor.orange
    }
    
    func setValue(values v : [UIView]) {
    }
}
