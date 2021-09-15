import UIKit

class ExcursionViewController: UIViewController {
    
    var id: Excursion? = nil
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var countStepLabel: UILabel!
    @IBOutlet weak var imageExcursion: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = id?.name
        descriptionLabel.text = "Добро пожаловать на экскурсию \(id?.name ?? "")"
        countStepLabel.text = "\(id?.steps.count ?? 0)"
        DispatchQueue.main.async {
            Loader.shared.loadImage(icon: self.id?.image ?? "") { (data) in
                self.imageExcursion.image = data
            }
        }
    }
    
    @IBAction func playStepAction(_ sender: Any) {
        let newView: StepsViewController = self.storyboard?.instantiateViewController(withIdentifier: "StepsViewController") as! StepsViewController
        newView.id = id
        present(newView, animated: true, completion: nil)
    }
    
}

