//
//  AddViewController.swift
//  project-lfg
//
//  Created by Witherspoon, Tosh T on 4/17/18.
//  Copyright © 2018 Team Accord. All rights reserved.
//

import Foundation
import Eureka

let getRanks = ["None": [], "League of Legends": ["Unranked", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Challenger"], "Rainbow Six Siege": ["Unranked", "Copper", "Bronze", "Silver", "Gold", "Platinum", "Diamond"], "Overwatch": ["Unranked", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Grandmaster", "Top 500"]]

class AddViewController: FormViewController {
    
    var GameName:String = ""
    var GameRank:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Game Choice")
            <<< ActionSheetRow<String>()
                {
                $0.tag = "GamePicker"
                $0.title = "Game Picker"
                $0.selectorTitle = "Pick a Game"
                $0.options = ["None","Overwatch","League of Legends","Rainbow Six Siege"]
                $0.value = "None"
                GameName = $0.value!
                }.onChange{ row in
                    self.GameName = row.value!;
                    self.addRankings()
                    print(self.GameName)
                }
        form +++ Section("Time Played")
            <<< PhoneRow() {
                $0.title = "Hours Played"
                $0.placeholder = "Hours Played"
                
        }
        form +++ Section("Rankings")
        
    }
    
    func addRankings()
    {
        form.allSections[2].removeAll()
        form.allSections[2]
            <<< ActionSheetRow<String>() { row in
                row.tag = "GameRank"
                row.title = "Rankings"
                row.selectorTitle = "Pick your rank"
                row.options = getRanks[self.GameName]!
                row.value = "None"
                GameRank = row.value!
                }.onChange{ row in
                    self.GameRank = row.value!;
                    print(self.GameRank)
        }
       
    }
}

