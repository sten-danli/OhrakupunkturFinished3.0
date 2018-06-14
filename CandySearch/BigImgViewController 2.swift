import UIKit

class BigImgViewController: UIViewController {
    var dataforBig:Indications!
    var infoFromDetailVC:String?
    @IBOutlet weak var bigImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bigImg.image=UIImage(named: infoFromDetailVC!)
    }
    
}
