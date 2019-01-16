//
//  registerViewController.swift
//  test
//
//  Created by Alex Iakab on 29/11/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import UIKit
import FirebaseAuth

class registerViewController: UIViewController {
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var registerView: UIView!
    let currentUser = Auth.auth().currentUser
    
    //    var email = ""
    //    var password = ""
    //    var passwordCheck = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        button.setCorner(8)
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.goodGreen
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.goodGreen.cgColor
        emailField.setBorderBottom(false)
        passwordField.setBorderBottom(false)
        passwordCheckField.setBorderBottom(false)
        registerView.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundD")!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func editingStartP(_ sender: UITextField) {
        sender.setBorderBottom(true)
    }
    @IBAction func editingEndP(_ sender: UITextField) {
        sender.setBorderBottom(false)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        let emailInput = emailField.text
        let passwordInput = passwordField.text
        let passwordCheckInput = passwordCheckField.text
        
        if currentUser == nil {
            if ((emailInput?.isEmpty)!) || ((passwordInput?.isEmpty)!) || ((passwordCheckInput?.isEmpty)!){
                alert(title: "Zonk", message: "Please fill in all the fields", option: "Try Again")
            } else {
                registerUser(email: emailInput!, password: passwordInput!, checkPassword: passwordCheckInput!)
                self.performSegue(withIdentifier: "registerPressed", sender: self)
            }
        } else {
            alert(title: "Logged In", message: "Something went wrong, you should not be here, please restart the app", option: "OK")
        }
    }
    
    func registerUser(email: String, password: String, checkPassword: String) {
        if password == checkPassword {
            Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
                // ...
                //                guard let user = authResult?.user else {return}
            }
        } else {
            alert(title: "Zonk", message: "Passwords do not match!", option: "Try Again")
        }
    }
    
    
    func alert(title: String, message: String, option: String) {
        let alert = UIAlertController(title:  title, message:  message , preferredStyle: .alert)
        
        let action = UIAlertAction(title: option, style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
}



extension UIView{
    func setBorderBottom(_ color : Bool ){
        let lineView = UIView()
        lineView.translatesAutoresizingMaskIntoConstraints = false // This is important!
        self.addSubview(lineView)
        
        let metrics = ["width" : NSNumber(value: 2)]
        let views = ["lineView" : lineView]
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[lineView]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[lineView(width)]|", options:NSLayoutConstraint.FormatOptions(rawValue: 0), metrics:metrics, views:views))
        
        if color == true {
            lineView.backgroundColor = UIColor.orange
        }
        else{
            lineView.backgroundColor = UIColor.white
        }
    }
}
