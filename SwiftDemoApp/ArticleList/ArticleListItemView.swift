//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

class ArticleListItemView: UITableViewCell {

    static let estimatedHeight = CGFloat(100 / 4 * 3 + 16 * 2)

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?

    var viewModel: ArticleListItemViewModel? {
        didSet {
            nameLabel?.text = viewModel?.name
            priceLabel?.text = viewModel?.price
        }
    }

    override func awakeFromNib() {
        separatorInset = .zero
    }
}
