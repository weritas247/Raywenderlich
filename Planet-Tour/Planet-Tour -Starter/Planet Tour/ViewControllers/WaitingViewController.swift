


import UIKit

class WaitingViewController: UIViewController {
  
  @IBOutlet weak var justAMomentLabel: UILabel!

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if RCValues.sharedInstance.fetchComplete {
      startAppForReal()
    }
    
    RCValues.sharedInstance.loadingDoneCallback = startAppForReal
  }

  
  func startAppForReal() {
    performSegue(withIdentifier: "loadingDoneSegue", sender: self)
  }

}
