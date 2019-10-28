

import UIKit

protocol KanjiListViewControllerDelegate: class {
    func kanjiListViewControllerDidSelectKanji(_ selectedKanji: Kanji)
}

class KanjiListViewController: UIViewController {
    weak var delegate: KanjiListViewControllerDelegate?
    
    @IBOutlet weak var kanjiListTableView: UITableView! {
        didSet {
            kanjiListTableView?.dataSource = self
            kanjiListTableView?.delegate = self
        }
    }
    
    var kanjiList: [Kanji] = [] {
        didSet {
            kanjiListTableView?.reloadData()
        }
    }
    
    var cellAccessoryType = UITableViewCellAccessoryType.disclosureIndicator
}

extension KanjiListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kanjiList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "ListItem") {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "ListItem")
        }
        let kanji = kanjiList[indexPath.row]
        cell.textLabel?.text = kanji.character
        cell.detailTextLabel?.text = kanji.meaning
        cell.accessoryType = cellAccessoryType
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let kanji = kanjiList[indexPath.row]
        delegate?.kanjiListViewControllerDidSelectKanji(kanji)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
