//
//  ButtonExtentions.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import UIKit

extension UIButton {
    public func asPrimary() {
        self.backgroundColor = UIColor.primary
        self.setTitleColor(UIColor.white, for: UIControl.State.normal)
    }
    
    public func asDefault() {
        self.backgroundColor = UIColor.clear
        self.setTitleColor(UIColor.primary, for: UIControl.State.normal)
    }
}
