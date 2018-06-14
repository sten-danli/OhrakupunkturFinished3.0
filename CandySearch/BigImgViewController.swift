import UIKit

class BigImgViewController: UIViewController {
    var dataforBig:Indications!
    var infoFromDetailVC:String?
    @IBOutlet weak var bigImg: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let okInfoFromDetailVC = infoFromDetailVC else {
            return
        }
        bigImg.image=UIImage(named: okInfoFromDetailVC)
    }
    
}
