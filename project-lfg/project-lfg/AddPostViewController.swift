import Foundation





import Firebase

import FirebaseFirestore

import Eureka





let getRanks = ["None": [], "League of Legends": ["Unranked", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Challenger"], "Rainbow Six Siege": ["Unranked", "Copper", "Bronze", "Silver", "Gold", "Platinum", "Diamond"], "Overwatch": ["Unranked", "Bronze", "Silver", "Gold", "Platinum", "Diamond", "Master", "Grandmaster", "Top 500"]]







class AddViewController: FormViewController {
    
    var Console:String = "PC"
    
    var GameName:String = ""
    
    var GameRank:String = ""
    
    var GameTime:String = ""
    
    var PostDesc:String = ""
    
    var uid: String = ""
    
    var displayName: String = ""
    
    var email: String = ""
    
    var PlayerWant: Int = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            
            print("onMainView user: \(String(describing: user)) auth: \(String(describing: user))")
            
            if user == nil{
                
                self.navigationController?.popToRootViewController(animated: true)
                
            }else{
                
                self.uid = (user?.uid)!
                
                self.email = (user?.email)!
                
                self.displayName = (user?.displayName ?? "")!
                
            }
            
        }
        
        
        
        self.setUp();
        
    }
    
    
    
    func setUp()
        
    {
        
        
        
        form +++ Section("Username")
            
            <<< TextRow()
                { text in
                    
                    text.title = "Username"
                    
                    text.placeholder = "Enter username here"
                    
                    text.value = ""
                    
                }.onChange{ text in
                    
                    if let textMess = text.value
                        
                    {
                        
                        self.displayName = textMess;
                        
                    }
                    
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
                    
                    
                    
                    self.PlayerWant = Int(want.value!)!
                    
                    
                    
                    print(self.PlayerWant)
                    
            }
            
            <<< ButtonRow() //the row of consisting of the button that uploads the information to net
                { addPost in
                    
                    addPost.title = "Create Post"
                    
                }
                
                .onCellSelection()
                    { addPost in
                        
                        self.uploadData();
        }
        
        animateScroll = true
        
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
        guard GameName == "" || GameRank == "" || GameTime == "" || uid == "" || displayName == "" || email == "" || PlayerWant == 0 else {
        
            print("Method call successful")
            
            let db = Firestore.firestore()
            
            db.collection("posts").addDocument(data:
                
                [
                    
                    "Platform" : Console ,
                    
                    "GameName" : GameName,
                    
                    "GameRank" : GameRank,
                    
                    "GameTime" : GameTime,
                    
                    "PostDesc" : PostDesc,
                    
                    "uid": uid,
                    
                    "displayName": self.displayName,
                    
                    "email": self.email,
                    
                    "dateCreated": FieldValue.serverTimestamp(),
                    
                    "PlayerWant"  : PlayerWant
                    
            ]) { err in
                
                if let err = err {
                    
                    print("Error writing document: \(err)")
                    
                } else {
                    
                    print("Document successfully written!")
                    
                }
                
                }
                
            
            
            
            
            //displaying message
            
            print("Posts Added")
            self.restart();
            return
        }
    }
    
    
    
    func restart()
        
    {
        
        form.removeAll();
        self.setUp();
        self.performSegue(withIdentifier: "Reset Home", sender: self)
    }
    
}
