//  Copyright © 2017 Derk Gommers. All rights reserved.

import Foundation

class ArticleListPresenter {

    weak var view: ArticleListView?
    let interactor: ArticleListInteractor
    let itemPresenter: ArticleListItemPresenterType

    fileprivate var requestedPage = UInt(0)
    fileprivate var currentPage = UInt(0)

    init(view: ArticleListView?, interactor: ArticleListInteractor,
         itemPresenter: ArticleListItemPresenterType = ArticleListItemPresenter()) {
        self.view = view
        self.interactor = interactor
        self.itemPresenter = itemPresenter
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
            self?.appendToViewModel(articles: articles)
        }
    }

    private func appendToViewModel(articles: [Article]) {
        let articles = articles.map(itemPresenter.viewModel)

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
