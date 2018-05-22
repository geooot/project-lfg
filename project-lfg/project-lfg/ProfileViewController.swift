//
//  ProfileViewController.swift
//  project-lfg
//
//  Created by Thayamkery, George B on 5/22/18.
//  Copyright © 2018 Team Accord. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOut(_ sender: UIButton) {
        do {
            try Firebase.Auth.auth().signOut()
            performSegue(withIdentifier: "goToLoader", sender: nil)
        } catch {
            print("Error signing out")
        }
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
