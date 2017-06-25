//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

class ArticleListItemView: UITableViewCell {

    static let estimatedHeight = CGFloat(100 / 4 * 3 + 16 * 2)

    @IBOutlet weak var titleLabel: UILabel?

    var viewModel: ArticleListItemViewModel? {
        didSet {
            titleLabel?.text = viewModel?.name
        }
    }

    override func awakeFromNib() {
        separatorInset = .zero
    }
}
