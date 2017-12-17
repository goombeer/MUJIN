//
//  CustomButton.swift
//  Bolts
//
//  Created by 高橋勇輝 on 2017/11/23.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
        // 角丸の半径(0で四角形)
        @IBInspectable var cornerRadius: CGFloat = 0.0
        
        // 枠
        @IBInspectable var borderColor: UIColor = UIColor.clear
        @IBInspectable var borderWidth: CGFloat = 0.0
        
        override func draw(_ rect: CGRect) {
            // 角丸
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = (cornerRadius > 0)
            
            // 枠線
            self.layer.borderColor = borderColor.cgColor
            self.layer.borderWidth = borderWidth
            
            super.draw(rect)
        }

    func turnOn() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.backgroundColor = UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0)
    }
    
    func turnOff() {
        self.setTitleColor(UIColor(red:0.96, green:0.55, blue:0.15, alpha:1.0), for: .normal)
        self.backgroundColor = UIColor.white
    }
}


