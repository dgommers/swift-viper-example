//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleListPresenterSpec: QuickSpec {
    override func spec() {

        var view: ArticleListViewStub!
        var interactor: ArticleListInteractorStub!
        var itemPresenter: ArticleListItemPresenterStub!
        var subject: ArticleListPresenter!

        beforeEach {
            view = ArticleListViewStub()
            interactor = ArticleListInteractorStub()
            itemPresenter = ArticleListItemPresenterStub()
            subject = ArticleListPresenter(view: view, interactor: interactor, itemPresenter: itemPresenter)
        }

        describe("view will appear") {
            beforeEach {
                subject.viewWillAppear()
            }

            it("loads the first page") {
                expect(interactor.invokedArticles?.page).to(equal(1))
            }

            describe("few article available") {
                let articles: [Article] = [.tesla, .tesla]

                beforeEach {
                    itemPresenter.returnViewModel.name = "Item"
                    interactor.invokedArticles?.completion(articles)
                }

                it("creates a view model for all articles") {
                    expect(itemPresenter.invokedViewModel.count).to(equal(2))
                }

                it("presents the created view model") {
                    let firstViewModel = view.viewModel?.articles.first
                    let expectedName = itemPresenter.returnViewModel.name
                    expect(firstViewModel?.name).to(equal(expectedName))
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
                interactor.invokedArticles?.completion([.tesla])
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
                    interactor.invokedArticles?.completion([.tesla])
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
