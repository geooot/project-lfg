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
    let datePosted: Date
    let description: String
    let firebaseId: String
    let game: String
    let platform: String
}

class ViewController: UITableViewController {
    var data = [CellData]()
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print("onMainView user: \(String(describing: user)) auth: \(String(describing: user))")
            if user == nil{
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            self.loadData()
        }

        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.delegate = self
        tableView.dataSource = self
    }

    @IBAction func reload(_ sender: UIBarButtonItem) {
        self.loadData()
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

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "postCell") as! PostTableViewCell
        cell.myCellLabel.text = "\(self.data[indexPath.row].username) wants \(self.data[indexPath.row].numOfPlayers) players"
        cell.filledInSpots.text = "\(self.data[indexPath.row].spotsTaken)/\(self.data[indexPath.row].numOfPlayers) Spots Taken"
        cell.datePosted.text = self.data[indexPath.row].datePosted.description
        cell.containerView.layer.borderColor = platformColors[self.data[indexPath.row].platform]?.cgColor
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func loadData(){
        data = []
        Firestore.firestore().collection("posts").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                    let item = document.data()
                    if(item.count > 0){
                        print(item)
                        let timestamp: Timestamp = document.get("dateCreated") as! Timestamp
                        let date = timestamp.dateValue()
                        self.data.append(CellData(username: item["displayName"] as! String, numOfPlayers: item["PlayerWant"] as! Int, spotsTaken: 0, datePosted: date, description: item["PostDesc"] as! String, firebaseId: document.documentID, game: item["GameName"] as! String, platform: item["Platform"] as! String))
                    }else{
                        print("No entries got!")
                    }
                }
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "ToDetailView", sender: data)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.data = data[selectedIndex]
    }
}

