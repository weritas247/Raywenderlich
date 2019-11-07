


import UIKit

class MiniMap: UIView {

  // MARK: - Properties
  var mapImage: UIImageView!
  var overviewImage: UIImageView!
  var frameRects: [CGRect]!
  let originalFrameBasis: CGFloat = 600;
  var oldPlanet: Int = -1

  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)

    frameRects = [
      CGRect(x: 21, y: 48, width: 27, height: 31),
      CGRect(x: 53, y: 47, width: 30, height: 30),
      CGRect(x: 97, y: 47, width: 30, height: 30),
      CGRect(x: 142, y: 52, width: 20, height: 20),
      CGRect(x: 174, y: 11, width: 105, height: 102),
      CGRect(x: 283, y: 5, width: 160, height: 107),
      CGRect(x: 427, y: 39, width: 45, height: 49),
      CGRect(x: 484, y: 40, width: 46, height: 46),
      CGRect(x: 547, y: 53, width: 17, height: 17)
    ]
    createMapImage()
    createOverviewImage()
  }

  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func createMapImage() {
    mapImage = UIImageView(image: UIImage(named: "SolarSystem"))
    mapImage.contentMode = .scaleAspectFit
    addSubview(mapImage)
  }

  func createOverviewImage() {
    let frameInsets = UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    overviewImage = UIImageView(image: UIImage(named: "PlanetFrame")?.resizableImage(withCapInsets: frameInsets))
    addSubview(overviewImage)
    showPlanet(number: 0)
  }

  func showPlanet(number planetNum: Int) {
    guard planetNum != oldPlanet else { return }

    oldPlanet = planetNum
    let normalRect = frameRects[planetNum]
    let multiplier = mapImage.bounds.width / originalFrameBasis
    let destinationRect = CGRect(x: normalRect.origin.x * multiplier,
                                 y: normalRect.origin.y * multiplier,
                                 width: normalRect.width * multiplier,
                                 height: normalRect.height * multiplier)
    UIView.animate(withDuration: 0.3, delay: 0.0, animations: {
      self.overviewImage.frame = destinationRect
    })
  }
}
