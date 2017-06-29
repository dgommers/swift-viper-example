//  Copyright © 2017 Derk Gommers. All rights reserved.

import UIKit

protocol ArticleListItemPresenterType {
    func viewModel(article: Article) -> ArticleListItemViewModel
}

struct ArticleListItemPresenter: ArticleListItemPresenterType {

    let unavailableAttributes = [
        NSForegroundColorAttributeName: UIColor.lightGray
    ]

    func viewModel(article: Article) -> ArticleListItemViewModel {
        return ArticleListItemViewModel(
            name: article.name,
            price: article.units?.first?.price?.formatted,
            image: article.media?.images?.first?.smallHdURL,
            units: article.units?.flatMap(unitAttributedText)
        )
    }

    func unitAttributedText(unit: ArticleUnit) -> NSAttributedString? {
        let available = unit.available ?? false
        return NSAttributedString(
            string: unit.size ?? "",
            attributes: available ? [:] : unavailableAttributes
        )
    }
}
