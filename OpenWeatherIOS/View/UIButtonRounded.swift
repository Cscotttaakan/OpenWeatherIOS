//
//  UIButtonRounded.swift
//  OpenWeatherIOS
//
//  Created by Craig Scott on 9/23/18.
//  Copyright © 2018 Craig Scott. All rights reserved.
//

import UIKit


class UIButtonRounded: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addBlurEffect()
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.clear.cgColor
        self.clipsToBounds = true
    }
    

}
