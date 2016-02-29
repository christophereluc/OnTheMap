//
//  RoundedButton.swift
//  On The Map
//
//  Created by Christopher Luc on 2/28/16.
//  Copyright © 2016 Christopher Luc. All rights reserved.
//

import Foundation
import UIKit

class RoundedButton : UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0;
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.clearColor().CGColor
        
    }
}