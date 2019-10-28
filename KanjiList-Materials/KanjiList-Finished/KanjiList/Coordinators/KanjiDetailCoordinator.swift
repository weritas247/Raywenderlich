

import UIKit

class KanjiDetailCoordinator: Coordinator {
  private let presenter: UINavigationController  // 1
  private var kanjiDetailViewController: KanjiDetailViewController? // 2
  private var wordKanjiListViewController: KanjiListViewController? // 3
  private let kanjiStorage: KanjiStorage  // 4
  private let kanji: Kanji  // 5
  
  init(presenter: UINavigationController,
       kanji: Kanji,
       kanjiStorage: KanjiStorage) {
    
    self.kanji = kanji
    self.presenter = presenter
    self.kanjiStorage = kanjiStorage  // 6
  }
  
  func start() {
    let kanjiDetailViewController = KanjiDetailViewController(nibName: nil, bundle: nil)
    kanjiDetailViewController.delegate = self
    kanjiDetailViewController.title = "Kanji details"
    kanjiDetailViewController.selectedKanji = kanji    // 7
    
    presenter.pushViewController(kanjiDetailViewController, animated: true)
    self.kanjiDetailViewController = kanjiDetailViewController  // 8
  }
}

// MARK: - KanjiDetailViewControllerDelegate
extension KanjiDetailCoordinator: KanjiDetailViewControllerDelegate {
  func kanjiDetailViewControllerDidSelectWord(_ word: String) {
    let wordKanjiListViewController = KanjiListViewController(nibName: nil, bundle: nil)
    wordKanjiListViewController.cellAccessoryType = .none
    let kanjiForWord = kanjiStorage.kanjiForWord(word)
    wordKanjiListViewController.kanjiList = kanjiForWord
    wordKanjiListViewController.title = word
    
    presenter.pushViewController(wordKanjiListViewController, animated: true)
  }
}
