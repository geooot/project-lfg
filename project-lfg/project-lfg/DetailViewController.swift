import UIKit
import Firebase

class DetailViewController: UIViewController {
    var data: CellData?
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Desc: UILabel!
    @IBOutlet weak var spotsFilled: UILabel!
    @IBOutlet weak var platformLine: UIView!
    @IBOutlet weak var platformText: UILabel!
    
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
                }

                self.refreshJoinedLabels()
            })
        }
    }
    
    @IBAction func joiningGroup(_ sender: UIButton) {
        showJoinDialog()
    }
    
    func addPersonToGroup(named name: String){
        if var data = data {
            data.peopleJoined.append(name)
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
            people += "\(person)\n"
        }
        joinedLabel.text = people
        spotsFilled.text? = "\(data.spotsTaken)/\(data.numOfPlayers) Spots Taken"
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
