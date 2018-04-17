//
//  AddViewController.swift
//  project-lfg
//
//  Created by Witherspoon, Tosh T on 4/17/18.
//  Copyright © 2018 Team Accord. All rights reserved.
//

import Foundation
import Eureka

class AddViewController: FormViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Game Choice")
            <<< ActionSheetRow<String>() {
                $0.title = "Game Picker"
                $0.selectorTitle = "Pick a Game"
                $0.options = ["None","Overwatch","League of Legends","Rainbow Six"]
                $0.tag = "GameName"
                $0.value = "None"
                
        }
    }
}
