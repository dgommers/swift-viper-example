//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

protocol ArticleListItemPresenterType {
    func viewModel(article: Article) -> ArticleListItemViewModel
}

struct ArticleListItemPresenter: ArticleListItemPresenterType {
    func viewModel(article: Article) -> ArticleListItemViewModel {
        return ArticleListItemViewModel(
            name: article.name,
            price: article.units?.first?.price?.formatted,
            image: article.media?.images?.first?.smallHdURL,
            units: article.units?.flatMap {
                NSAttributedString(string: $0.size ?? "")
            }
        )
    }
}
