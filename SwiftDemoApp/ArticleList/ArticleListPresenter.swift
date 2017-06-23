//  Copyright © 2017 Derk Gommers. All rights reserved.

struct ArticleListPresenter {
    weak var view: ArticleListView?
    let interactor: ArticleListInteractor
}

extension ArticleListPresenter: ArticleListEventHandler {
    func viewWillAppear() {
        view?.viewModel = ArticleListViewModel(articles: [ArticleListItemViewModel(title: "Example")])
    }
}
