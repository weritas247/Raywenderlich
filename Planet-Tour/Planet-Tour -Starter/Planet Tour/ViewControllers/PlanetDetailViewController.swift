


import UIKit

class PlanetDetailViewController: UIViewController {

  // MARK: - IBOutlets
  @IBOutlet weak var planetNameLabel: UILabel!
  @IBOutlet weak var planetImage: UIImageView!
  @IBOutlet weak var yearLengthLabel: UILabel!
  @IBOutlet weak var massTitle: UILabel!
  @IBOutlet weak var yearTitle: UILabel!
  @IBOutlet weak var funFactTitle: UILabel!
  @IBOutlet weak var massLabel: UILabel!
  @IBOutlet weak var funFactLabel: UILabel!
  @IBOutlet weak var imageCreditLabel: UILabel!

  // MARK: - Properties
  var planet: Planet?

  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    updateLabelColors()
    updateLookForPlanet()
  }
}

// MARK: - Private
private extension PlanetDetailViewController {

  func updateLabelColors() {
    for case let nextLabel? in [yearTitle, massTitle, funFactTitle] {
      nextLabel.textColor = RCValues.sharedInstance.color(forKey: .appPrimaryColor)
    }

    for case let nextLabel? in [yearLengthLabel, massLabel, funFactLabel] {
      nextLabel.textColor = RCValues.sharedInstance.color(forKey: .detailInfoColor)

    }

    planetNameLabel.textColor = RCValues.sharedInstance.color(forKey: .detailTitleColor)

  }

  func updateLookForPlanet() {
    guard let planet = planet else { return }
    planetNameLabel.text = planet.name
    planetImage.image = planet.image
    yearLengthLabel.text = String(planet.yearInDays)
    massLabel.text = String(planet.massInEarths)
    funFactLabel.text = planet.funFact
    imageCreditLabel.text = "Image credit: \(planet.imageCredit)"
  }
}
