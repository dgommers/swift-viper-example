//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

protocol ArticleListItemPresenterType {
    func viewModel(article: Article) -> ArticleListItemViewModel
}

struct ArticleListItemPresenter: ArticleListItemPresenterType {

    private let textOutOfStock = "Out of stock"
    private let textInStock = "in stock"

    let unavailableAttributes = [
        NSForegroundColorAttributeName: UIColor.lightGray
    ]

    func viewModel(article: Article) -> ArticleListItemViewModel {
        let stockLevel = combinedStockLevel(units: article.units)

        return ArticleListItemViewModel(
            name: article.name,
            price: article.units?.first?.price?.formatted,
            image: article.media?.images?.first?.smallHdURL,
            units: article.units?.flatMap(unitAttributedText),
            stock: stockText(level: stockLevel),
            stockColor: stockColor(level: stockLevel)
        )
    }

    private func stockColor(level: Int) -> UIColor {
        return level > 0 ? .green : .red
    }

    private func stockText(level: Int) -> String {
        return level > 0 ? "\(level) \(textInStock)" : textOutOfStock
    }

    private func combinedStockLevel(units: [ArticleUnit]?) -> Int {
        guard let units = units else { return 0 }
        return units
            .flatMap({ $0.stock })
            .reduce(0, +)
    }

    private func unitAttributedText(unit: ArticleUnit) -> NSAttributedString? {
        let available = unit.available ?? false
        return NSAttributedString(
            string: unit.size ?? "",
            attributes: available ? [:] : unavailableAttributes
        )
    }
}
