//  Copyright © 2017 Derk Gommers. All rights reserved.

protocol ArticleListView {
    var viewModel: ArticleListViewModel? { get set }
}

class ArticleListPresenter {
    var view: ArticleListView

    init(view: ArticleListView) {
        self.view = view
    }

    func viewWillAppear() {
        view.viewModel = ArticleListViewModel(articles: [ArticleListItemViewModel(title: "Example")])
    }
}
