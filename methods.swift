//
//  methods.swift
//  Grounded
//
//  Created by artlawson on 6/15/20.
//  Copyright © 2020 artlawson. All rights reserved.
//

//used to provide additional methods across the whole project

import Foundation
import UIKit


let relativeFontConstant: CGFloat = 0.05 //scalar for stretching
extension UIViewController{
    //font scalar functions for label, button, text, box
     func lbl_font_scalar(obj: UILabel) {
         obj.font.withSize(self.view.frame.height * relativeFontConstant)
     }
     func txt_font_scalar(obj: UITextField) {
         obj.font!.withSize(self.view.frame.height * relativeFontConstant)
     }
     //func txt_font_scalar(obj: UIButton) {
        // obj.font.withSize(self.view.frame.height * //relativeFontConstant)
    // }
}


//call __button__.setDynamicFontSize()
extension UIButton {
    
    func setDynamicFontSize() {
        NotificationCenter.default.addObserver(self, selector: #selector(setButtonDynamicFontSize),
                                               name: UIContentSizeCategory.didChangeNotification,
                                               object: nil)
    }
    
    @objc func setButtonDynamicFontSize() {
        Common.setButtonTextSizeDynamic(button: self, textStyle: .callout)
    }
    
    class Common {
        
        class func setButtonTextSizeDynamic(button: UIButton, textStyle: UIFont.TextStyle) {
            button.titleLabel?.font = UIFont.preferredFont(forTextStyle: textStyle)
            button.titleLabel?.adjustsFontForContentSizeCategory = true
        }
        
    }
    
}

//helper function to make sure that labels have two zeros when double representing them may not have
func zero_check(num: String)-> String{
    let i = num.index(num.startIndex, offsetBy: num.count-3)
    if num[i] != "." {
        return num + "0"
    }
    return num
}


