//  Copyright © 2017 Derk Gommers. All rights reserved.

struct ArticleListViewModel {
    var articles: [ArticleListItemViewModel]
}

struct ArticleListItemViewModel {
    var name: String?
    var price: String?
}