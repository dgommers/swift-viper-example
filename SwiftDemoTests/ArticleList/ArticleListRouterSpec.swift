//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleListRouterSpec: QuickSpec {
    override func spec() {
        var subject: ArticleListRouter!

        beforeEach {
            subject = ArticleListRouter()
        }

        describe("view controller") {
            var viewController: ArticleListViewController?
            var presenter: ArticleListPresenter?

            beforeEach {
                viewController = subject.viewController() as? ArticleListViewController
                presenter = viewController?.eventHandler as? ArticleListPresenter
            }

            it("wires up the view to presenter") {
                expect(presenter?.view).to(beIdenticalTo(viewController))
            }

            it("wires up the interactor to presenter") {
                expect(presenter?.interactor is ArticleListZalandoInteractor).to(beTrue())
            }

        }
    }
}
