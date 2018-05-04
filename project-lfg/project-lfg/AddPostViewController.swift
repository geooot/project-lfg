import Foundation
import Eureka
import Firebase


let getRanks = ["None": [], "League of Legends": ["Unranked", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Challenger"], "Rainbow Six Siege": ["Unranked", "Copper", "Bronze", "Silver", "Gold", "Platinum", "Diamond"], "Overwatch": ["Unranked", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Grandmaster", "Top 500"]]



class AddViewController: FormViewController {
    
    
    
    var Console:String = "PC"
    
    var GameName:String = ""
    
    var GameRank:String = ""
    
    var GameTime:String = ""
    
    var PostDesc:String = ""
    
    var PlayerWant:Int = 0
    
    var uid:String = ""
    
    var email:String = ""
    
    var displayName:String = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Auth.auth().addStateDidChangeListener { (auth, user) in
            print("onMainView user: \(String(describing: user)) auth: \(String(describing: user))")
            if user == nil{
                self.navigationController?.popToRootViewController(animated: true)
            }else{
                self.uid = (user?.uid)!
                self.email = (user?.email)!
                
            }
        }
        
        form +++ Section("Gamertag")
            
            <<< PhoneRow() {
                
                $0.title = "Username"
                
                $0.placeholder = "Username"
                
                
                
                }.onChange{ row in
                    
                    self.displayName = row.value ?? ""
                    
                    print(self.displayName)
                    
        }
        
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
                    
                    self.GameName = row.value!
                    
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
                    
                    self.PostDesc = row.value ?? ""
                    
                    print(self.PostDesc)
                    
        }
        
        form +++ Section("Players Wanted")
            
            <<< ActionSheetRow<Int>() { want in
                
                want.tag = "PlayerWant"
                
                want.title = "Players Wanted"
                
                want.selectorTitle = "Pick Player Count"
                
                want.options = [1, 2, 3, 4, 5]
                
                want.value = 1
                
                }.onChange{ want in
                    
                    self.PlayerWant = want.value!
                    
                    print(self.PlayerWant)
        }
            <<< ButtonRow()
                { addPost in
                    addPost.title = "Create Post"
                }
                .onCellSelection()
                {_,_ in
                        self.uploadData()
                }
    }
    
    
    
    func addRankings()
        
    {
        
        form.allSections[4].removeAll()
        
        form.allSections[4]
            
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
    func uploadData()
    {
        let db = Firestore.firestore()
        var ref: DocumentReference? = nil
        ref = db.collection("posts").addDocument(data: [
            "Platform": Console,
            "GameName": GameName,
            "GameRank": GameRank,
            "dateCreated": FieldValue.serverTimestamp(),
            "PostDesc": PostDesc,
            "PlayerWant": PlayerWant,
            "uid": self.uid,
            "email": self.email,
            "displayName": self.displayName
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
}
