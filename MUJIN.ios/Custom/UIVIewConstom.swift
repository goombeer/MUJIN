//
//  UIVIewConstom.swift
//  MUJIN.ios
//
//  Created by 高橋勇輝 on 2017/12/03.
//  Copyright © 2017年 高橋勇輝. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class UIVIewConstom: UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
    @IBInspectable var shapeBackgroundColor: UIColor? {
        get { return UIColor() }
        set { self.layer.backgroundColor = newValue?.cgColor }
    }
}
