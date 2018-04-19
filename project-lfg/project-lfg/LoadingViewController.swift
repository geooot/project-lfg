//
//  LoadingViewController.swift
//  project-lfg
//
//  Created by Thayamkery, George B on 4/19/18.
//  Copyright © 2018 Team Accord. All rights reserved.
//

import UIKit
import Firebase

class LoadingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print("onLoadingView user: \(String(describing: user)) auth: \(String(describing: user))")
            if user == nil{
                self.performSegue(withIdentifier: "goToAuthView", sender: nil)
            }else{
                self.performSegue(withIdentifier: "goToMainView", sender: nil)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
