


import UIKit

class CrossfadeSegue: UIStoryboardSegue {

  override func perform() {
    let secondVCView = destination.view
    secondVCView?.alpha = 0.0
    source.navigationController?.pushViewController(destination, animated: false)
    UIView.animate(withDuration: 0.4) { 
      secondVCView?.alpha = 1.0
    }
  }
}
