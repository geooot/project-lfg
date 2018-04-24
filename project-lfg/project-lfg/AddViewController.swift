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
    
    var Console:String = ""
    var GameName:String = ""
    var GameRank:String = ""
    var GameTime:String = ""
    var PostDesc:String = ""
    var PlayerWant:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Console")
            <<< ActionSheetRow<String>()
                { console in
                console.tag = "ConsoleChoice"
                console.title = "Console"
                console.selectorTitle = "Choose your Console"
                console.options = ["PC", "Xbox One", "Playstation 4"]
                console.value = "PC"
                }.onChange{ console in
                    self.Console = console.value!
                    print(self.Console)
                }
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
                
                }.onChange{ row in
                    self.GameTime = row.value!
                    print(self.GameTime)
        }
        
        form +++ Section("Rankings")
        form +++ Section("Description")
            <<< TextAreaRow()
                { desc in
                  desc.tag = "PostDesc"
                  desc.title = "Post Description"
                  desc.placeholder = "Post a Desctription"
                }.onChange{ row in
                    self.PostDesc = row.value!
                    print(self.PostDesc)
                }
        form +++ Section("Players Wanted")
            <<< ActionSheetRow<String>() { want in
                want.tag = "PlayerWant"
                want.title = "Players Wanted"
                want.selectorTitle = "Pick Player Count"
                want.options = ["1", "2", "3", "4", "5"]
                want.value = "1"
                }.onChange{ want in
                    self.PlayerWant = want.value!
                    print(self.PlayerWant)
                }
    }
    
    func addRankings()
    {
        form.allSections[3].removeAll()
        form.allSections[3]
            <<< ActionSheetRow<String>() { rank in
                rank.tag = "GameRank"
                rank.title = "Rankings"
                rank.selectorTitle = "Pick your rank"
                rank.options = getRanks[self.GameName]!
                rank.value = "None"
                GameRank = rank.value!
                }.onChange{ rank in
                    self.GameRank = rank.value!;
                    print(self.GameRank)
        }
       
    }
}

