//
//  ViewController.swift
//  project-lfg
//
//  Created by Thayamkery, George B on 4/13/18.
//  Copyright © 2018 Team Accord. All rights reserved.
//

import UIKit
import Firebase

struct CellData {
    let username: String
    let numOfPlayers: Int
    let spotsTaken: Int
    let datePosted: String
    let description: String
    let firebaseId: String
}

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print("onMainView user: \(String(describing: user)) auth: \(String(describing: user))")
            if user == nil{
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }

    @IBAction func signOut(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
}

