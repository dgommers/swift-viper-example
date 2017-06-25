//  Copyright © 2017 Derk Gommers. All rights reserved.

class ArticleListPresenter {

    weak var view: ArticleListView?
    let interactor: ArticleListInteractor

    fileprivate var requestedPage = UInt(0)
    fileprivate var currentPage = UInt(0)

    init(view: ArticleListView?, interactor: ArticleListInteractor) {
        self.view = view
        self.interactor = interactor
    }

    fileprivate func presentNextPage() {
        let isIdle = requestedPage == currentPage
        if isIdle {
            present(page: currentPage + 1)
        }
    }

    private func present(page: UInt) {
        requestedPage = page
        interactor.articles(page: page) { [weak self] articles in
            self?.currentPage = page
            self?.appendToViewModel(articles: articles.flatMap { $0.name })
        }
    }

    private func appendToViewModel(articles: [String]) {
        let articles = articles.map { title in
            ArticleListItemViewModel(title: title)
        }

        if view?.viewModel == nil {
            view?.viewModel = ArticleListViewModel(articles: articles)
        } else {
            view?.viewModel?.articles.append(contentsOf: articles)
        }
    }
}

extension ArticleListPresenter: ArticleListEventHandler {
    func viewDidReachBottom() {
        presentNextPage()
    }

    func viewWillAppear() {
        if currentPage == 0 {
            presentNextPage()
        }
    }
}
