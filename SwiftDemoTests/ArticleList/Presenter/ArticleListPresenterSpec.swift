//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleListPresenterSpec: QuickSpec {
    override func spec() {

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
                var itemViewModel: ArticleListItemViewModel?

                beforeEach {
                    interactor.invokedArticles?.completion([.tesla])
                    itemViewModel = view.viewModel?.articles.first
                }

                it("takes the article name") {
                    expect(itemViewModel?.name).to(equal(Article.tesla.name))
                }

                it("takes the first formatted unit price") {
                    let expected = Article.tesla.units?.first?.price?.formatted
                    expect(itemViewModel?.price).to(equal(expected))
                }

                it("takes the first small hd image url") {
                    let expected = Article.tesla.media?.images?.first?.smallHdURL
                    expect(itemViewModel?.image).to(equal(expected))
                }

                describe("units") {
                    it("shows all units") {
                        expect(itemViewModel?.units?.count).to(equal(2))
                    }

                    describe("first") {
                        var unit: NSAttributedString?

                        beforeEach {
                            unit = itemViewModel?.units?.first
                        }

                        it("shows the size") {
                            expect(unit?.string).to(equal("M"))
                        }
                    }
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

private extension Article {
    static let tesla: Article = {
        var image = ArticleImage()
        image.smallHdURL = URL(string: "example")

        var media = ArticleMedia()
        media.images = [image]

        var price = ArticlePrice()
        price.formatted = "€ 200.000"

        var mUnit = ArticleUnit()
        mUnit.size = "M"
        mUnit.price = price

        var sUnit = ArticleUnit()
        sUnit.size = "S"

        var article = Article()
        article.name = "Tesla Model X"
        article.units = [mUnit, sUnit]
        article.media = media
        return article
    }()
}
