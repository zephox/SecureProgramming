//
//  menuViewController.swift
//  test
//
//  Created by Alex Iakab on 01/12/2018.
//  Copyright © 2018 Alex Iakab. All rights reserved.
//

import UIKit
import Firebase

class menuViewController: UIViewController {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet var viewController: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewController.backgroundColor = UIColor(patternImage: UIImage(named: "BackgroundD")!)
        setUpViews()
    }
    func setUpViews(){
        self.view1.setCorner(6)
        self.view1.setShadow()
        self.view2.setCorner(6)
        self.view2.setShadow()
        self.view3.setCorner(6)
        self.view3.setShadow()
        self.view4.setCorner(6)
        self.view4.setShadow()
    }
    @IBAction func toGamelist(_ sender: UIButton) {
        performSegue(withIdentifier: "toGamelist", sender: self)
    }
    @IBAction func test(_ sender: UIButton) {
        performSegue(withIdentifier: "toSpecs", sender: self)
    }
    @IBAction func toBuild(_ sender: UIButton) {
     performSegue(withIdentifier: "toBuild", sender: self)
    }
    
    @IBAction func signOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "signOutPressed", sender: self)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
extension UIView{
    func setCorner(_ value:CGFloat){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.cornerRadius = value
    }
    func setShadow(){
        self.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
