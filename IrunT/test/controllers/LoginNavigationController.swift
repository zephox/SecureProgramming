//
//  LoginNavigationController.swift
//  test
//
//  Created by Mirek Nalepa on 16/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginNavigationController : UINavigationController {
    
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = Auth.auth().currentUser
        if currentUser != nil {
            loadHomeScreen()
        }
    }
    
    func loadHomeScreen(){
        //        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loggedInNavigationController = storyboard?.instantiateViewController(withIdentifier: "LoggedInNavigationController") as! LoggedInNavigationController
        self.present(loggedInNavigationController, animated: true, completion: nil)
    }
}
