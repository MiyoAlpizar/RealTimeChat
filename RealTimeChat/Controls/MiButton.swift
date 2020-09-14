//
//  PrimaryButton.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import UIKit

enum ButtonStyle {
    case primary
    case regular
}

class MiButton: UIButton {

    private var buttonStyle: ButtonStyle = .regular
    
    override init(frame: CGRect) {
        super.init(type: UIButton.ButtonType)
    }
    
    init(type: UIButton.ButtonType,style: ButtonStyle) {
        buttonStyle = style
        super.init(type: type)
    }
    
    private func setStyle() {
        switch buttonStyle {
        case .primary:
            self.backgroundColor = UIColor.primary
            self.setTitleColor(UIColor.white, for: UIControl.State.normal)
        default:
            self.backgroundColor = UIColor.clear
            self.setTitleColor(UIColor.primary, for: UIControl.State.normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
