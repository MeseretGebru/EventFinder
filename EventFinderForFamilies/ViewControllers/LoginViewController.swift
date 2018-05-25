//
//  ViewController.swift
//  EventFinderForFamilies
//
//  Created by C4Q on 5/16/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {
let loginView = LoginView()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Active")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = imageView.bounds.width/2.0
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = Stylesheet.Colors.Lapislazuli
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Navigation barcolor
       logoImageView.setNeedsLayout()
        navigationController?.navigationBar.barTintColor = Stylesheet.Contexts.NavigationController.BarColor
        //TODO: change title color...
        
        //TODo: textfield delegate
        
        loginViewConstraints()
        loginView.emailTextField.resignFirstResponder()
        
    }
        
    func loginViewConstraints(){
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height).multipliedBy(0.3)
            make.centerX.equalTo(view)
        }
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom)
            make.width.equalTo(view.snp.width)
            make.bottom.equalTo(view.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
    @objc private func login() {
        
        
    }
    
    


}

    




    


