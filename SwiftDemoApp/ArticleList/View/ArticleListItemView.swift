//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit
import SDWebImage

class ArticleListItemView: UITableViewCell {

    static let estimatedHeight = CGFloat(100 / 4 * 3 + 16 * 2)

    @IBOutlet weak var nameLabel: UILabel?
    @IBOutlet weak var priceLabel: UILabel?
    @IBOutlet weak var stockLabel: UILabel?
    @IBOutlet weak var stockIndicatorView: UIView?
    @IBOutlet weak var itemImageView: UIImageView?

    var viewModel: ArticleListItemViewModel? {
        didSet {
            nameLabel?.text = viewModel?.name
            priceLabel?.text = viewModel?.price
            stockLabel?.text = nil
            itemImageView?.sd_setImage(with: viewModel?.image)
        }
    }

    override func awakeFromNib() {
        separatorInset = .zero
    }
}
