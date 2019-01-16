//
//  LoggedInNavigationController.swift
//  test
//
//  Created by Mirek Nalepa on 16/01/2019.
//  Copyright © 2019 Alex Iakab. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoggedInNavigationController : UINavigationController {
    override func viewDidAppear(_ animated: Bool) {
        let currentUser = Auth.auth().currentUser
        if currentUser == nil {
            //            loadLoginScreen()
        } else {
            debugPrint(currentUser as Any)
            
        }
    }
    
    func loadLoginScreen(){
        let loginNavigationController = storyboard?.instantiateViewController(withIdentifier: "LoginNavigationController") as! LoginNavigationController
        self.present(loginNavigationController, animated: true, completion: nil)
    }
}
