import UIKit

class StepsViewController: UIViewController {
    @IBOutlet weak var stepsTable: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var id: Excursion? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = id?.name
        // Do any additional setup after loading the view.
    }

}

extension StepsViewController: UITableViewDataSource, UITableViewDelegate{
    

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return id?.steps.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "StepsTableViewCell") as! StepsTableViewCell

        cell.initCell(item: id!.steps[indexPath.row])
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newView: PlayerViewController = self.storyboard?.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        newView.step = id!.steps[indexPath.row]
        present(newView, animated: true, completion: nil)
    }
    
  
}
