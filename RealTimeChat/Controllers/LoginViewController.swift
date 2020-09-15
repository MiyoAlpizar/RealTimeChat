//
//  LoginViewController.swift
//  RealTimeChat
//
//  Created by Miyo Alpízar on 14/09/20.
//  Copyright © 2020 Miyo Alpízar. All rights reserved.
//

import UIKit
import SVProgressHUD
class LoginViewController: ScrollViewController {
    
    let logo: UIImageView = {
        let logo = UIImageView()
        logo.contentMode = .scaleAspectFit
        logo.image = #imageLiteral(resourceName: "Image")
        return logo
    }()
    
    private let txtEmail: UITextField = {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        txt.returnKeyType = .next
        txt.autocapitalizationType = .none
        txt.keyboardType = .emailAddress
        txt.placeholder = "Email"
        return txt
    }()
    
    private let txtPwd: UITextField = {
        let txt = UITextField()
        txt.borderStyle = .roundedRect
        txt.returnKeyType = .done
        txt.placeholder = "Password"
        txt.isSecureTextEntry = true
        return txt
    }()
    
    private let btnLogin: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setTitle("Log In", for: UIControl.State.normal)
        btn.asPrimary()
        return btn
    }()
    
    private let btnForgotPassword: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setTitle("Forgot password?", for: UIControl.State.normal)
        btn.asDefault()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.light)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInit()
    }
    
    func setInit() {
        title = "Login"
        addViews()
        layoutViews()
        addTargets()
    }
    
    private func addTargets() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel",
                                                           style: UIBarButtonItem.Style.plain,
                                                           target: self,
                                                           action: #selector(close))
        btnLogin.addTarget(self, action: #selector(validateLogin), for: UIControl.Event.touchUpInside)
        
        btnForgotPassword.addTarget(self, action: #selector(forgotPassword), for: UIControl.Event.touchUpInside)
    }
    
    @objc func close() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func forgotPassword() {
        self.view.endEditing(true)
        
        if !txtEmail.isValidEmail() {
            alert(message: "Please write your E-mail Address to send you your recovery password link") { [weak self] in
                guard let `self` = self else { return }
                self.txtEmail.becomeFirstResponder()
            }
            return
        }
        SVProgressHUD.show()
        UserHelper.shared.sendEmailToRecoveryPassword(with: txtEmail.text!) { [weak self] (result) in
            SVProgressHUD.dismiss()
            guard let `self` = self else { return }
            switch result {
            case .success(_):
                self.alert(message: "Link to recovery password was succesful send to " + self.txtEmail.text!)
            case .failure(let error):
                self.alert(title: "Error to send recovery password", message: error.localizedDescription)
            }
        }
        
    }
    
    @objc func validateLogin() {
        
        view.endEditing(true)
        
        if !txtEmail.isValidEmail() {
            alert(message: "You must enter a valid E-mail") { [weak self] in
                guard let `self` = self else { return }
                self.txtEmail.becomeFirstResponder()
            }
            return
        }
        
        if txtPwd.isLessThan(count: 6) {
            alert(message: "You must enter a password with 6 characters min") { [weak self] in
                guard let `self` = self else { return }
                self.txtPwd.becomeFirstResponder()
            }
            return
        }
        SVProgressHUD.show()
        UserHelper.shared.login(email: txtEmail.text!, pwd: txtPwd.text!) { [weak self] (result) in
            SVProgressHUD.dismiss()
            guard let `self` = self else { return }
            switch result {
            case .success(_):
                self.goMain()
            case .failure(let error):
                self.alert(message: error.localizedDescription)
            }
        }
        
        
    }
    
    private func goMain() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window!.rootViewController = MainTabViewController()
    }
    
}

//MARK: - ViewsAndLayouts
extension LoginViewController {
    
    private func addViews() {
        scrollView.keyboardDismissMode = .none
        contentView.addSubview(logo)
        contentView.addSubview(txtEmail)
        contentView.addSubview(txtPwd)
        contentView.addSubview(btnLogin)
        contentView.addSubview(btnForgotPassword)
        txtEmail.delegate = self
        txtPwd.delegate = self
    }
    
    private func layoutViews() {
        let height: CGFloat = 44
        let widthBy: CGFloat = 0.86
        
        
        logo.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(self.windowInsets.top + 20)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
        
        txtEmail.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(widthBy)
            make.top.equalTo(logo.snp.bottom).offset(12)
            make.height.equalTo(height)
        }
        
        txtPwd.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(widthBy)
            make.top.equalTo(txtEmail.snp.bottom).offset(12)
            make.height.equalTo(height)
        }
        
        btnLogin.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(widthBy)
            make.top.equalTo(txtPwd.snp.bottom).offset(36)
            make.height.equalTo(54)
        }
        
        btnForgotPassword.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(widthBy)
            make.top.equalTo(btnLogin.snp.bottom).offset(12)
            make.height.equalTo(54)
        }
    }
    
}

//MARK: -Delegates
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case txtEmail:
            txtPwd.becomeFirstResponder()
            break
        default:
            validateLogin()
        }
        return true
    }
}
