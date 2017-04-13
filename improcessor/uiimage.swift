//
//  uiimage.swift
//  improcessor
//
//  Created by student on 13.04.17.
//  Copyright © 2017 Илья Лошкарёв. All rights reserved.
//

import Foundation
import  UIKit

extension UIImage {
    
    class func addText(_ drawText: NSString, inImage: UIImage,  atPoint: CGPoint, textColor: UIColor, textFont: UIFont) -> UIImage {
        
        
        //Setups up the font attributes that will be later used to dictate how the text should be drawn
        let textFontAttributes = [
            NSFontAttributeName: textFont,
            NSForegroundColorAttributeName: textColor,
            ]
        
        // Create bitmap based graphics context
        UIGraphicsBeginImageContextWithOptions(inImage.size, false, 0.0)
        
        
        //Put the image into a rectangle as large as the original image.
        inImage.draw(in: CGRect(x:0,y: 0, width: inImage.size.width,height: inImage.size.height))
        
        // Our drawing bounds
        let drawingBounds = CGRect(x: 0.0,y:  0.0,width: inImage.size.width, height: inImage.size.height)
        
        let textSize = drawText.size(attributes: [NSFontAttributeName:textFont])
        let textRect = CGRect(x: 0, y: 0,
                              width: textSize.width, height: textSize.height)
        
        drawText.draw(in: textRect, withAttributes: textFontAttributes)
        
        // Get the image from the graphics context
        let newImag = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImag!
    }
}
