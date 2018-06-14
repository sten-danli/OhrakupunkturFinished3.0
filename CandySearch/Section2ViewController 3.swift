import UIKit

class Section2ViewController: UIViewController {
    
    
    @IBOutlet weak var textlabel: UILabel!
    
    var section1Index: String? {
        didSet {
            configureView()
            print("DID SET CALLED \(section1Index)")
        }
    }
    func configureView() {
        if let section1IndexUnwrapped = section1Index {
            print("Section name is: \(section1IndexUnwrapped)")
            if let textlabel = textlabel {
                textlabel.text = section1IndexUnwrapped
                print("hier ist:\(section1IndexUnwrapped)")
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
