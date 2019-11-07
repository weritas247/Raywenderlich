


import UIKit

class GetNewsletterViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var instructionLabel: UILabel!
  @IBOutlet weak var thankYouLabel: UILabel!
  @IBOutlet weak var submitButton: UIButton!
  @IBOutlet weak var emailTextField: UITextField!

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    updateText()
    updateSubmitButton()
    thankYouLabel.isHidden = true
  }
}

// MARK: - IBActions
extension GetNewsletterViewController {

  @IBAction func submitButtonWasPressed(_ sender: AnyObject) {
    // We won't actually submit an email, but we can pretend
    submitButton.isHidden = true
    thankYouLabel.isHidden = false
    emailTextField.isEnabled = false
  }
}

// MARK: - Private
private extension GetNewsletterViewController {

  func updateText() {
    instructionLabel.text = RCValues.sharedInstance.string(forKey: .subscribeVCText)
    submitButton.setTitle(RCValues.sharedInstance.string(forKey: .subscribeVCButton), for: .normal)
  }

  
  func updateSubmitButton() {
    submitButton.backgroundColor = RCValues.sharedInstance.color(forKey: .appPrimaryColor)
    submitButton.layer.cornerRadius = 5.0
  }
}
