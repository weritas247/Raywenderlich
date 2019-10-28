

import UIKit

class ApplicationCoordinator: Coordinator {
  let kanjiStorage: KanjiStorage //  1
  let window: UIWindow  // 2
  let rootViewController: UINavigationController  // 3
  let allKanjiListCoordinator: AllKanjiListCoordinator
  
  init(window: UIWindow) {
    self.window = window
    kanjiStorage = KanjiStorage()
    rootViewController = UINavigationController()
    rootViewController.navigationBar.prefersLargeTitles = true  // 4
    
    allKanjiListCoordinator = AllKanjiListCoordinator(presenter: rootViewController, kanjiStorage: kanjiStorage)
  }
  
  func start() {  // 6
    window.rootViewController = rootViewController
    allKanjiListCoordinator.start()
    window.makeKeyAndVisible()
  }
}
