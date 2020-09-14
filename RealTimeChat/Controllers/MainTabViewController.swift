//
//  MainTabViewController.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import UIKit

class MainTabViewController: UITabBarController {
    
    private let contactsVC: ContactsViewController = {
        let home = ContactsViewController()
        return home
    }()
    
    private lazy var contactsNC: UINavigationController = {
        let nc = UINavigationController(rootViewController: contactsVC)
        nc.title = "Contactos"
        return nc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [contactsNC]
    }
    
}
