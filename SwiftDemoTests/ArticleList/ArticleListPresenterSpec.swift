//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleListPresenterSpec: QuickSpec {
    override func spec() {

        let articleTitleCat = "Cat"
        let articleTitlePizza = "Pizza"

        var view: ArticleListViewStub!
        var interactor: ArticleListInteractorStub!
        var subject: ArticleListPresenter!

        beforeEach {
            view = ArticleListViewStub()
            interactor = ArticleListInteractorStub()
            subject = ArticleListPresenter(view: view, interactor: interactor)
        }

        describe("view will appear") {
            beforeEach {
                subject.viewWillAppear()
            }

            it("loads the first page") {
                expect(interactor.invokedArticles?.page).to(equal(1))
            }

            describe("one article available") {
                beforeEach {
                    interactor.invokedArticles?.completion([articleTitleCat])
                }

                it("presents the article") {
                    expect(view.viewModel?.articles.first?.title).to(equal(articleTitleCat))
                }
            }

            describe("view will appear") {
                beforeEach {
                    interactor.invokedArticles = nil
                    subject.viewWillAppear()
                }

                it("does not get articles again") {
                    expect(interactor.invokedArticles).to(beNil())
                }
            }
        }

        describe("view did reach bottom") {
            beforeEach {
                subject.viewWillAppear()
                interactor.invokedArticles?.completion([articleTitleCat])
                subject.viewDidReachBottom()
            }

            it("loads the second page") {
                expect(interactor.invokedArticles?.page).to(equal(2))
            }

            describe("view did reach bottom") {
                beforeEach {
                    subject.viewDidReachBottom()
                }

                it("does not loads the third page immediately") {
                    expect(interactor.invokedArticles?.page).toNot(equal(3))
                }
            }

            describe("another article available") {
                beforeEach {
                    interactor.invokedArticles?.completion([articleTitlePizza])
                }

                it("presents the other article as well") {
                    expect(view.viewModel?.articles.last?.title).to(equal(articleTitlePizza))
                }

                it("shows two articles in total") {
                    expect(view.viewModel?.articles.count).to(equal(2))
                }

                describe("view did reach bottom") {
                    beforeEach {
                        subject.viewDidReachBottom()
                    }

                    it("loads the third page") {
                        expect(interactor.invokedArticles?.page).to(equal(3))
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

    var invokedArticles: (page: UInt, completion: ([String]) -> Void)?

    func articles(page: UInt, completion: @escaping ([String]) -> Void) {
        invokedArticles = (page, completion)
    }
}
