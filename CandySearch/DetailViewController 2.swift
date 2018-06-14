import UIKit
import AVKit

class DetailViewController: UIViewController {
  
    @IBOutlet weak var detailDescriptionLabel: UILabel!
  
    @IBOutlet weak var myImageView: UIImageView!
  
    @IBOutlet weak var punktZahleLabel: UILabel!
    
    @IBOutlet weak var weitereIndikation: UITextView!
    
    @IBOutlet weak var beschreibung: UITextView!
    
    @IBAction func videoInfoButton(_ sender: Any) {
        if let path=Bundle.main.path(forResource: "video", ofType: "mp4"){
            let video=AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlay=AVPlayerViewController()
            videoPlay.player=video
            
            present(videoPlay, animated: true, completion: {
                
                video.play()
            })
        }
    }
    
    var detailIndications: Indications? {
        
    didSet {
      configureView()
          }
    }
  func configureView() {
    if let detailIndications = detailIndications {
        if let detailDescriptionLabel = detailDescriptionLabel, let myImageView = myImageView , let punktZahleLabel=punktZahleLabel,let weitereIndikation=weitereIndikation,let beschreibung=beschreibung  {
            detailDescriptionLabel.text = detailIndications.name
            myImageView.image = UIImage(named: detailIndications.name)
            punktZahleLabel.text=detailIndications.numOfPoint
            weitereIndikation.text=detailIndications.indication
            beschreibung.text=detailIndications.beschreibung
        title = detailIndications.name
      }
    }
  }
    func addTapGestureToMyImg(){
        let tapGesture=UITapGestureRecognizer(target: self, action: #selector(handleIntoBigViewImg))
        myImageView.addGestureRecognizer(tapGesture)
        myImageView.isUserInteractionEnabled=true
    }
    @objc func handleIntoBigViewImg(){
        print("cklik")
        performSegue(withIdentifier: "gotobigimg", sender: detailIndications?.name)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotobigimg"{
            if let bigImgViewController=segue.destination as? BigImgViewController{
                bigImgViewController.infoFromDetailVC = sender as? String
            }
        }
    }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    addTapGestureToMyImg()

  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}

