//
//  LoginViewController.swift
//  test
//
//  Created by Alex Iakab on 29/11/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet var viewController: UIView!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    var currentUser: User?
    
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
        currentUser = Auth.auth().currentUser
        
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
        Auth.auth().signInAnonymously() { (authResult, error) in
            self.performSegue(withIdentifier: "loginPressed", sender: self)
        }
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
//        performSegue(withIdentifier: "loginPressed", sender: self)
        
        let emailInput = usernameField.text
        let passwordInput = passwordField.text
        
        if self.currentUser == nil {
            if ((emailInput?.isEmpty)!) || ((passwordInput?.isEmpty)!) {
                alert(title: "Zonk", message: "Please fill in all the fields", option: "Try Again")
            } else {
                loginUser(email: emailInput!, password: passwordInput!)
            }
        } else {
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                alert(title: "Zonk", message: "You were somehow logged in so we logged you out", option: "Log In Again")
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }
    }
    
    func loginUser(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            self.currentUser = user?.user

            if self.currentUser != nil {
                self.performSegue(withIdentifier: "loginPressed", sender: self)
            } else {
                self.alert(title: "Zonk", message: "Email or Password incorrect", option: "Try Again")
            }
        }
        
    }
    
    func alert(title: String, message: String, option: String) {
        let alert = UIAlertController(title:  title, message:  message , preferredStyle: .alert)
        
        let action = UIAlertAction(title: option, style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
