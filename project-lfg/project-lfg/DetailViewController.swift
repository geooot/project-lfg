import UIKit

class DetailViewController: UIViewController {
    var data: CellData?
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var Desc: UILabel!
    @IBOutlet weak var spotsFilled: UILabel!
    @IBOutlet weak var platformLine: UIView!
    @IBOutlet weak var platformText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Desc.text? = "\(data!.description)"
        userName.text? = "\(data!.username) wants \(data!.numOfPlayers) Players to play \(data!.game)!"
        spotsFilled.text? = "\(data!.spotsTaken)/\(data!.numOfPlayers) Spots Taken"
        platformLine.backgroundColor = platformColors[data!.platform]!
        platformText.text? = "Platform: \(data!.platform)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
