//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble
import UIKit

@testable import SwiftDemoApp

class ArticleListItemPresenterSpec: QuickSpec {
    override func spec() {

        var subject: ArticleListItemPresenter!
        var viewModel: ArticleListItemViewModel!

        beforeEach {
            subject = ArticleListItemPresenter()
        }

        describe("available article") {
            beforeEach {
                viewModel = subject.viewModel(article: .tesla)
            }

            it("takes the article name") {
                expect(viewModel?.name).to(equal(Article.tesla.name))
            }

            it("takes the first formatted unit price") {
                let expected = Article.tesla.units?.first?.price?.formatted
                expect(viewModel?.price).to(equal(expected))
            }

            it("takes the first small hd image url") {
                let expected = Article.tesla.media?.images?.first?.smallHdURL
                expect(viewModel?.image).to(equal(expected))
            }

            it("combines all unit stock levels") {
                let combinedStockLevel = 10 + 1 + 0
                let expectedText = "\(combinedStockLevel) in stock"
                expect(viewModel?.stock).to(equal(expectedText))
            }

            it("shows green stock text") {
                expect(viewModel?.stockColor).to(equal(UIColor.darkGreen))
            }

            describe("units") {
                it("shows all units") {
                    expect(viewModel?.units?.count).to(equal(3))
                }

                describe("available unit") {
                    var unit: NSAttributedString?

                    beforeEach {
                        unit = viewModel?.units?.first
                    }

                    it("shows the size") {
                        expect(unit?.string).to(equal("M"))
                    }

                    it("has the default color") {
                        let color = unit?.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: nil)
                        expect(color).to(beNil())
                    }
                }

                describe("unavailable unit") {
                    var unit: NSAttributedString?

                    beforeEach {
                        unit = viewModel?.units?.last
                    }

                    it("shows the size") {
                        expect(unit?.string).to(equal("S"))
                    }

                    it("has the light gray color") {
                        let color = unit?.attribute(NSForegroundColorAttributeName, at: 0, effectiveRange: nil)
                        expect(UIColor.lightGray.isEqual(color)).to(beTrue())
                    }
                }
            }
        }

        describe("unavailable article") {
            beforeEach {
                var article = Article.tesla
                article.units = [.unavailable]
                viewModel = subject.viewModel(article: article)
            }

            it("shows out of stock") {
                let expectedText = "Out of stock"
                expect(viewModel?.stock).to(equal(expectedText))
            }

            it("shown stock text is dark orange") {
                expect(viewModel?.stockColor).to(equal(UIColor.darkOrange))
            }
        }
    }
}

extension Article {
    static let tesla: Article = {
        var image = ArticleImage()
        image.smallHdURL = URL(string: "example")

        var media = ArticleMedia()
        media.images = [image]

        var price = ArticlePrice()
        price.formatted = "€ 200.000"

        var mUnit = ArticleUnit()
        mUnit.size = "M"
        mUnit.stock = 10
        mUnit.available = true
        mUnit.price = price

        var lUnit = ArticleUnit()
        lUnit.size = "L"
        lUnit.stock = 1

        var sUnit = ArticleUnit()
        sUnit.size = "S"
        sUnit.stock = 0
        sUnit.available = false

        var article = Article()
        article.name = "Tesla Model X"
        article.units = [mUnit, lUnit, sUnit]
        article.media = media
        return article
    }()
}

extension ArticleUnit {
    static let unavailable: ArticleUnit = {
        var unit = ArticleUnit()
        unit.stock = 0
        unit.available = false
        return unit
    }()
}
