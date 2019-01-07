//
//  LoginViewController.swift
//  test
//
//  Created by Alex Iakab on 29/11/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet var viewController: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = imageView.image!.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = UIColor.goodGreen
        button.setCorner(8)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.goodGreen.cgColor
        guestButton.setCorner(8)
        guestButton.layer.borderWidth = 1
        guestButton.layer.borderColor = UIColor.goodGreen.cgColor
        registerButton.setCorner(8)
        registerButton.layer.borderWidth = 1
        registerButton.layer.borderColor = UIColor.goodGreen.cgColor
        passwordField.setBorderBottom(false)
        usernameField.setBorderBottom(false)
        viewController.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundD")!)
    }
    
    @IBAction func editingBegin(_ sender: UITextField) {
        sender.setBorderBottom(true)
    }
    
    @IBAction func editingEnd(_ sender: UITextField) {
    sender.setBorderBottom(false)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "registerPressed", sender: self)
    }
    
    @IBAction func guestLoginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "loginPressed", sender: self)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "loginPressed", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginPressed"{
        }
    }
}
