//
//  StartViewController.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import UIKit
import SnapKit

class StartViewController: UIViewController {
    
    var yConstraint: Constraint!
    var topConstraint: Constraint!
    
    let logo: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.image = #imageLiteral(resourceName: "Image")
        return logo
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.asPrimary()
        button.alpha = 0
        button.layer.cornerRadius = 16
        button.setTitle("Log In", for: UIControl.State.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.asDefault()
        button.alpha = 0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.light)
        button.setTitle("Create Account", for: UIControl.State.normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addViews()
        autoLayOut()
        animateLogo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
}

//MARK: ViewsAndLayout
extension StartViewController {
    
    private func animateLogo() {
        self.delayWithSeconds(0.6) { [weak self] in
            guard let `self` = self else { return }
            UIView.animate(withDuration: 0.3) { [weak self] in
                guard let `self` = self else { return }
                self.yConstraint.deactivate()
                self.topConstraint.activate()
                self.registerButton.alpha = 1.0
                self.loginButton.alpha = 1.0
                self.view.layoutIfNeeded()
            }
        }
    }
    
    private func addViews() {
        view.addSubview(logo)
        view.addSubview(registerButton)
        view.addSubview(loginButton)
    }
    
    private func autoLayOut() {
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            yConstraint = make.centerY.equalToSuperview().constraint
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        logo.snp.prepareConstraints { (prepare) in
            topConstraint = prepare.top.equalToSuperview().offset(self.windowInsets.top + 49).constraint
        }
        
        registerButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-(self.windowInsets.bottom + 40))
            make.height.equalTo(52)
        }
        
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.bottom.equalTo(registerButton.snp.top).offset(-20)
            make.height.equalTo(52)
        }
    }
    
}