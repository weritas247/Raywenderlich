


import UIKit

public struct Planet {

  // MARK: - Properties
  public let name: String
  public let yearInDays: Double
  public let massInEarths: Double
  public let radiusInEarths: Double
  public let funFact: String
  public let image: UIImage
  public let imageCredit: String

  // MARK: - Initializers
  public init(name: String, yearInDays: Double, massInEarths: Double, radiusInEarths: Double, funFact: String, imageName: String, imageCredit: String) {
    self.name = name
    self.yearInDays = yearInDays
    self.massInEarths = massInEarths
    self.radiusInEarths = radiusInEarths
    self.funFact = funFact
    self.image = UIImage(named: imageName)!
    self.imageCredit = imageCredit
  }
}
