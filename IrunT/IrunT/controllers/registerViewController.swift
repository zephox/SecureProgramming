//
//  registerViewController.swift
//  test
//
//  Created by Alex Iakab on 29/11/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import UIKit

class registerViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var registerView: UIView!
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
    @IBAction func editingStartP(_ sender: UITextField) {
        sender.setBorderBottom(true)
    }
    @IBAction func editingEndP(_ sender: UITextField) {
        sender.setBorderBottom(false)
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
