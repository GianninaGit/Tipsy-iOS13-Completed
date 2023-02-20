
import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsLabel: UILabel!
    
    var resultadoValue: String?
    var numberOfPeople: String?
    var tip: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = resultadoValue
        settingsLabel.text = "Split between \(numberOfPeople!) people, with \(tip!)% tip."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}
