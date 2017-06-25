//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleListPresenterSpec: QuickSpec {
    override func spec() {

        let articleTitle = "Example Article"

        var view: ArticleListViewStub!
        var interactor: ArticleListInteractorStub!
        var subject: ArticleListPresenter!

        beforeEach {
            view = ArticleListViewStub()
            interactor = ArticleListInteractorStub()
            subject = ArticleListPresenter(view: view, interactor: interactor)
        }

        describe("view will appear") {
            context("one article available") {
                beforeEach {
                    interactor.articles = [articleTitle]
                    subject.viewWillAppear()
                }

                it("gets the first page") {
                    expect(interactor.invokedArticlesPage).to(equal(1))
                }

                it("presents the article") {
                    expect(view.viewModel?.articles.first?.title).to(equal(articleTitle))
                }

                describe("view will appear") {
                    beforeEach {
                        interactor.invokedArticlesPage = nil
                        subject.viewWillAppear()
                    }

                    it("does not get articles again") {
                        expect(interactor.invokedArticlesPage).to(beNil())
                    }
                }
            }
        }
    }
}

private class ArticleListViewStub: ArticleListView {
    var viewModel: ArticleListViewModel?
}

private class ArticleListInteractorStub: ArticleListInteractor {
    var invokedArticlesPage: UInt?
    var articles = [String]()

    func articles(page: UInt, completion: @escaping ([String]) -> Void) {
        invokedArticlesPage = page
        completion(articles)
    }
}
