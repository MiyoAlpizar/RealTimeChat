//
//  StartViewController.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    let logo: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.primary
        label.font = UIFont.systemFont(ofSize: 32, weight: UIFont.Weight.light)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetViews()
    }
    
}
