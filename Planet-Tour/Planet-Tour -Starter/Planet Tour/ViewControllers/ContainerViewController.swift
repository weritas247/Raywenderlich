


import UIKit

class ContainerViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var bannerView: UIView!
  @IBOutlet weak var bannerLabel: UILabel!
  @IBOutlet weak var getNewsletterButton: UIButton!

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    updateBanner()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    updateNavigationColors()
  }
}

// MARK: - Private
private extension ContainerViewController {

  func updateNavigationColors() {
    navigationController?.navigationBar.tintColor = RCValues.sharedInstance.color(forKey: .navTintColor)
  }

  
  func updateBanner() {
    bannerView.backgroundColor = RCValues.sharedInstance.color(forKey: .appPrimaryColor)
    bannerLabel.text = RCValues.sharedInstance.string(forKey: .subscribeBannerText)
    getNewsletterButton.setTitle(RCValues.sharedInstance.string(forKey: .subscribeBannerButton), for: .normal)
  }
}

// MARK: - IBActions
extension ContainerViewController {

  @IBAction func getNewsletterButtonWasPressed(_ sender: AnyObject) {
    // No-op right now.
  }
}
