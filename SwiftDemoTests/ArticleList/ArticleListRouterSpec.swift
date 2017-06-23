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

            beforeEach {
                viewController = subject.viewController() as? ArticleListViewController
            }

            it("wires up the presenter") {
                let presenter = viewController?.eventHandler as? ArticleListPresenter
                expect(presenter?.view).to(beIdenticalTo(viewController))
            }
        }
    }
}
