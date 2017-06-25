//  Copyright © 2017 Derk Gommers. All rights reserved.

class ArticleListPresenter {

    weak var view: ArticleListView?
    let interactor: ArticleListInteractor

    private var currentPage = UInt(0)

    init(view: ArticleListView?, interactor: ArticleListInteractor) {
        self.view = view
        self.interactor = interactor
    }

    fileprivate func present() {
        guard currentPage == 0 else { return }
        currentPage += 1

        interactor.articles(page: 1) { [weak self] articles in
            let items = articles.map { title in
                ArticleListItemViewModel(title: title)
            }
            self?.view?.viewModel = ArticleListViewModel(articles: items)
        }
    }
}

extension ArticleListPresenter: ArticleListEventHandler {
    func viewDidReachBottom() {

    }

    func viewWillAppear() {
        present()
    }
}
