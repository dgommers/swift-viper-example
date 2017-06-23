//  Copyright © 2017 Derk Gommers. All rights reserved.

struct ArticleListPresenter {
    var view: ArticleListView?

    init(view: ArticleListView) {
        self.view = view
    }
}

extension ArticleListPresenter: ArticleListEventHandler {
    func viewWillAppear() {
        view?.viewModel = ArticleListViewModel(articles: [ArticleListItemViewModel(title: "Example")])
    }
}
