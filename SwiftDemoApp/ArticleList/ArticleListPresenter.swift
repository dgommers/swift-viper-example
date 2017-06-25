//  Copyright © 2017 Derk Gommers. All rights reserved.

struct ArticleListPresenter {
    weak var view: ArticleListView?
    let interactor: ArticleListInteractor

    fileprivate func present() {
        interactor.articles { titles in
            let items = titles.map { title in
                ArticleListItemViewModel(title: title)
            }
            self.view?.viewModel = ArticleListViewModel(articles: items)
        }
    }
}

extension ArticleListPresenter: ArticleListEventHandler {
    func viewWillAppear() {
        present()
    }
}
