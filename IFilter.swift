//
//  IFilter.swift
//  improcessor
//
//  Created by student on 30.03.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import UIKit

class settings {
    public var set : [String : (Any, Any, Any)] = [:]
    
    init (allSetting s: [String : (Any, Any, Any)]) {
        set = s
    }

    
    func getAmountOfSettings() -> Int {
        return set.count
    }
}


protocol FilterDelegate {
    func getFilterName() -> String
    
    func getSetting() -> settings
    
    func  getCintrols(width w: Int) -> [UIView]?
    
    func getResultSetting() -> [String : Any]
    
    func  getColor() -> UIColor
    
    func setValue(values v : [UIView])
}


func getRandomColor() -> UIColor{
    
    let randomRed:CGFloat = CGFloat(drand48())
    
    let randomGreen:CGFloat = CGFloat(drand48())
    
    let randomBlue:CGFloat = CGFloat(drand48())
    
    return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    
}
