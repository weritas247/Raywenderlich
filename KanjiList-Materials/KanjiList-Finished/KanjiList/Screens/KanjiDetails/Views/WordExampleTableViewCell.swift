

import UIKit

class WordExampleTableViewCell: UITableViewCell {
  func setupCell(data: WordExample?) {
    textLabel?.text = data?.word
    detailTextLabel?.text = data?.meaning
  }
}
