//  Copyright © 2017 Derk Gommers. All rights reserved.

import KIF
import Quick
import Nimble
import SDWebImage

@testable import SwiftDemoApp

class ArticleListViewControllerSpec: QuickSpec {
    override func spec() {

        var eventHandler: ArticleListEventHandlerStub!
        var subject: ArticleListViewController!

        beforeSuite {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ArticleListViewController")
            let navigationController = UINavigationController(rootViewController: viewController)

            subject = viewController as? ArticleListViewController
            UIApplication.shared.keyWindow?.rootViewController = navigationController
        }

        beforeEach {
            eventHandler = ArticleListEventHandlerStub()
            subject.eventHandler = eventHandler
        }

        func waitForItem(at row: Int) -> ArticleListItemView? {
            let indexPath = IndexPath(row: row, section: 0)
            return self.tester().waitForCellInTableView(at: indexPath) as? ArticleListItemView
        }

        it("has title 'Articles'") {
            expect(subject.navigationItem.title).to(equal("Articles"))
        }

        self.capture(name: "no articles")

        describe("view will appear") {
            beforeEach {
                subject.viewWillAppear(false)
            }

            it("fires a view will appear event") {
                expect(eventHandler.invokedViewWillAppear).to(beTrue())
            }
        }

        describe("update") {
            describe("three articles available") {
                beforeEach {
                    subject.viewModel = ArticleListViewModel(articles: [.mugshot, .selfie, .apple])
                }

                self.capture(name: "three articles")

                describe("first article") {
                    var item: ArticleListItemView?

                    beforeEach {
                        item = waitForItem(at: 0)
                    }

                    it("shows the title") {
                        expect(item?.nameLabel?.text).to(equal(ArticleListItemViewModel.mugshot.name))
                    }

                    it("loads the image") {
                        expect(item?.itemImageView?.sd_imageURL()).to(equal(ArticleListItemViewModel.mugshot.image))
                    }

                    it("shows the price") {
                        expect(item?.priceLabel?.text).to(equal(ArticleListItemViewModel.mugshot.price))
                    }

                    it("shows the sizes with spacing") {
                        let expectedWithSpacing = "M  S  "
                        expect(item?.sizesLabel?.attributedText?.string).to(equal(expectedWithSpacing))
                    }

                    it("shows the stock message") {
                        expect(item?.stockLabel?.text).to(equal(ArticleListItemViewModel.mugshot.stock))
                    }

                    it("shows the stock message in the right color") {
                        let stockColor = ArticleListItemViewModel.mugshot.stockColor
                        expect(item?.stockLabel?.textColor).to(equal(stockColor))
                    }

                    it("shows the stock indicator in the right color") {
                        let stockColor = ArticleListItemViewModel.mugshot.stockColor
                        expect(item?.stockIndicatorView?.backgroundColor).to(equal(stockColor))
                    }
                }

                it("shows the last title") {
                    let item = waitForItem(at: 2)
                    expect(item?.nameLabel?.text).to(equal(ArticleListItemViewModel.apple.name))
                }
            }

            describe("many articles available") {
                let numberOfArticles = 40

                beforeEach {
                    subject.viewModel = ArticleListViewModel(articles:
                        Array(repeating: .mugshot, count: numberOfArticles)
                    )
                }

                self.capture(name: "many articles")

                describe("scroll to last row") {
                    beforeEach {
                        _ = waitForItem(at: numberOfArticles - 1)
                    }

                    it("fires a view did reach bottom event") {
                        expect(eventHandler.invokedDidReachBottom).to(beTrue())
                    }
                }
            }
        }
    }
}

extension ArticleListItemViewModel {
    static let mugshot = ArticleListItemViewModel(
        name: "Mugshot Maker PRO+",
        price: "€ 100",
        image: URL(string: "https://mugshot.com/image.png"),
        units: [NSAttributedString(string: "M"), NSAttributedString(string: "S")],
        stock: "Out of stock",
        stockColor: .darkOrange
    )

    static let selfie = ArticleListItemViewModel(
        name: "Selfie Stick",
        price: nil, image: nil, units: nil, stock: nil, stockColor: nil
    )
    static let apple = ArticleListItemViewModel(
        name: "Apple iPhone",
        price: "€ 50.00", image: nil, units: nil, stock: nil, stockColor: nil
    )
}
