//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

class ArticleListItemView: UITableViewCell {

    static let estimatedHeight = CGFloat(100 / 4 * 3 + 16 * 2)

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var stockLabel: UILabel?
    @IBOutlet weak var stockIndicatorView: UIView?

    var viewModel: ArticleListItemViewModel? {
        didSet {
            nameLabel?.text = viewModel?.name
            priceLabel?.text = viewModel?.price
            stockLabel?.text = nil
        }
    }

    override func awakeFromNib() {
        separatorInset = .zero
    }
}
