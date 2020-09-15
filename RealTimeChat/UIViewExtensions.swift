//
//  UIViewExtensions.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import UIKit

extension UIView {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.dismissKeyboard))
        tap.cancelsTouchesInView = true
        self.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
}
