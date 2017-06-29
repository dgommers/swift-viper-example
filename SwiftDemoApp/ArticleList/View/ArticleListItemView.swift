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
    @IBOutlet weak var sizesLabel: UILabel?

    var viewModel: ArticleListItemViewModel? {
        didSet {
            nameLabel?.text = viewModel?.name
            priceLabel?.text = viewModel?.price
            stockLabel?.text = viewModel?.stock
            stockIndicatorView?.backgroundColor = viewModel?.stockColor
            stockLabel?.textColor = viewModel?.stockColor
            sizesLabel?.attributedText = viewModel?.mergedUnits

            setImage(url: viewModel?.image)
        }
    }

    private func setImage(url: URL?) {
        itemImageView?.sd_setShowActivityIndicatorView(true)
        itemImageView?.sd_setIndicatorStyle(.gray)
        itemImageView?.sd_setImage(with: url)
    }

    override func awakeFromNib() {
        separatorInset = .zero
    }
}

private extension ArticleListItemViewModel {
    var mergedUnits: NSAttributedString? {
        guard let units = units else { return nil }
        let spacing = NSAttributedString(string: "  ")
        let attributedText = NSMutableAttributedString()
        for unit in units {
            attributedText.append(unit)
            attributedText.append(spacing)
        }
        return attributedText
    }
}
