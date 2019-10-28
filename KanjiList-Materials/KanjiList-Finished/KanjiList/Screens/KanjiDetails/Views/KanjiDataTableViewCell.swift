

import UIKit

class KanjiDataTableViewCell: UITableViewCell {
  @IBOutlet weak var characterLabel: UILabel!
  @IBOutlet weak var meaningValueLabel: UILabel!
  
  func setupCell(data: Kanji?) {
    meaningValueLabel?.text = data?.meaning
    characterLabel?.text = data?.character
  }
}
