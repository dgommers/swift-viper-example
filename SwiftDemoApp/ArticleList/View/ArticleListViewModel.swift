//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

struct ArticleListViewModel {
    var articles: [ArticleListItemViewModel]
}

struct ArticleListItemViewModel {
    var name: String?
    var price: String?
    var image: URL?
}
