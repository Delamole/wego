import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var excursionTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return excursions.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "ExcursionTableViewCell") as! ExcursionTableViewCell

        cell.initCell(item: excursions[indexPath.row])
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newView: ExcursionViewController = self.storyboard?.instantiateViewController(withIdentifier: "ExcursionViewController") as! ExcursionViewController
        newView.id = excursions[indexPath.row]
        present(newView, animated: true, completion: nil)
    }
    
  
}
