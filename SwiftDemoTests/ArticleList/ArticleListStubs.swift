//  Copyright © 2017 Derk Gommers. All rights reserved.

@testable import SwiftDemoApp

class ArticleListViewStub: ArticleListView {
    var viewModel: ArticleListViewModel?
}

class ArticleListInteractorStub: ArticleListInteractor {

    var invokedArticles: (page: UInt, completion: ([Article]) -> Void)?

    func articles(page: UInt, completion: @escaping ([Article]) -> Void) {
        invokedArticles = (page, completion)
    }
}

class ArticleListEventHandlerStub: ArticleListEventHandler {

    var invokedViewWillAppear = false
    var invokedDidReachBottom = false

    func viewWillAppear() {
        invokedViewWillAppear = true
    }

    func viewDidReachBottom() {
        invokedDidReachBottom = true
    }
}
