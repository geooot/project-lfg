import UIKit
import Firebase

class DetailViewController: UIViewController {
    var data: CellData?
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Desc: UILabel!
    @IBOutlet weak var spotsFilled: UILabel!
    @IBOutlet weak var platformLine: UIView!
    @IBOutlet weak var platformText: UILabel!
    
    @IBOutlet weak var joinBtn: UIButton!
    @IBOutlet weak var gameRankText: UILabel!
    @IBOutlet weak var joinedLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = data{
            Desc.text? = "\(data.description)"
            userName.text? = "\(data.username) wants \(data.numOfPlayers) Players to play \(data.game)!"
            spotsFilled.text? = "\(data.spotsTaken)/\(data.numOfPlayers) Spots Taken"
            platformLine.backgroundColor = platformColors[data.platform]
            platformText.text? = "Platform: \(data.platform)"
            gameRankText.text? = data.gameRank
            
            
            Firestore.firestore().collection("posts").document(data.firebaseId).addSnapshotListener({ documentSnapshot, error in
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                let obj = document.data()
                if let joined = obj?["peopleJoined"] as? [String]{
                    self.data?.peopleJoined = joined
                    self.data?.spotsTaken = joined.endIndex
                    print("NEW PEOPLE JOINED", joined)
                    
                    
                    if(self.alreadyJoined()){
                        self.joinBtn.setTitle("Leave Group", for: .normal)
                    }else{
                        self.joinBtn.setTitle("Join Group", for: .normal)
                    }
                }

                self.refreshJoinedLabels()
            })
        }
    }
    
    @IBAction func joiningGroup(_ sender: UIButton) {
 
        if(alreadyJoined()){
            guard var data = data else {
                print("Error refreshJoinedLables")
                return
            }
            data.peopleJoined.remove(at: getIndexOfAlreadyJoinedPlayer())
            Firestore.firestore().collection("posts").document(data.firebaseId).updateData(["peopleJoined": data.peopleJoined])
        }else{
           showJoinDialog()
        }
        
    }
    
    func addPersonToGroup(named name: String){
        if var data = data {
            let userID = Auth.auth().currentUser!.uid
            data.peopleJoined.append(name+"_!_"+userID)
        Firestore.firestore().collection("posts").document(data.firebaseId).updateData(["peopleJoined": data.peopleJoined])
        }
    }
    
    func refreshJoinedLabels(){
        guard let data = data else {
            print("Error refreshJoinedLables")
            return
        }
        var people = ""
        for person in data.peopleJoined{
            let tmp = person.components(separatedBy: "_!_")
            people += "\(tmp[0])\n"
        }
        joinedLabel.text = people
        spotsFilled.text? = "\(data.spotsTaken)/\(data.numOfPlayers) Spots Taken"
    }
    
    func alreadyJoined() -> Bool{
        guard let joined = self.data?.peopleJoined else {
            return false
        }
        let userID = Auth.auth().currentUser!.uid
        
        for item in joined{
            if item.contains(userID) {
                return true
            }
        }
        return false
    }
    
    func getIndexOfAlreadyJoinedPlayer() -> Int {
        guard let joined = self.data?.peopleJoined else {
            return -1
        }
        let userID = Auth.auth().currentUser!.uid
        
        for (index, item) in joined.enumerated(){
            if item.contains(userID) {
                return index
            }
        }
        return -1
    }
    
    
    func showJoinDialog() {
        let alertController = UIAlertController(title: "Before you join...", message: "Enter your \(data!.game) username", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Join Group", style: .default) { (_) in
            let displayName = alertController.textFields?[0].text
            
            print(displayName ?? "Nothing")
            if let name = displayName {
                self.addPersonToGroup(named: name)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter game username"
        }
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
