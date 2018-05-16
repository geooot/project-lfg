import UIKit

class DetailViewController: UIViewController {
    var data: CellData?
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Desc: UILabel!
    @IBOutlet weak var spotsFilled: UILabel!
    @IBOutlet weak var platformLine: UIView!
    @IBOutlet weak var platformText: UILabel!
    
    @IBOutlet weak var gameRankText: UILabel!
    @IBOutlet weak var joinedPlayersStack: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
        Desc.text? = "\(data!.description)"
        userName.text? = "\(data!.username) wants \(data!.numOfPlayers) Players to play \(data!.game)!"
        spotsFilled.text? = "\(data!.spotsTaken)/\(data!.numOfPlayers) Spots Taken"
        platformLine.backgroundColor = platformColors[data!.platform]!
        platformText.text? = "Platform: \(data!.platform)"
        gameRankText.text? = data!.gameRank
    }
    
    @IBAction func joiningGroup(_ sender: UIButton) {
        showJoinDialog()
    }
    
    func addPersonToGroup(named name: String){

    }
    
    func showJoinDialog() {
        let alertController = UIAlertController(title: "Before you join...", message: "Enter your \(data!.game) username", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Join Group", style: .default) { (_) in
            let displayName = alertController.textFields?[0].text
            
            print(displayName ?? "Nothing")
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
