import UIKit
import AVKit

class Section2ViewController: UIViewController {
    
    
    @IBOutlet weak var textlabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func infoVideoButton(_ sender: Any) {
    playLocalVideo()
        }
    
    func playLocalVideo(){
        guard let okSection1Index=detailSection1Index  else {return}
        if let path=Bundle.main.path(forResource: "\(String(describing: okSection1Index.name))", ofType: "mp4"){
            let video=AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlay=AVPlayerViewController()
            videoPlay.player=video
            
            present(videoPlay, animated: true, completion: {
                
                video.play()
            })
        }
    }
    
    var detailSection1Index: Section1Index? {
        didSet {
            configureView()
                }
        }
    
    func configureView() {
        if let section1IndexUnwrapped = detailSection1Index {
            if let textlabel = textlabel,let textView=textView {
                textlabel.text = section1IndexUnwrapped.name
                textView.text = section1IndexUnwrapped.beschreibung
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
