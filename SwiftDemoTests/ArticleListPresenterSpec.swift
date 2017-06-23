//  Copyright © 2017 Derk Gommers. All rights reserved.

import Quick
import Nimble

@testable import SwiftDemoApp

class ArticleListPresenterSpec: QuickSpec {
    override func spec() {
        var view: ArticleListViewStub!
        var subject: ArticleListPresenter!

        beforeEach {
            view = ArticleListViewStub()
            subject = ArticleListPresenter(view: view)
        }

        describe("view will appear") {
            beforeEach {
                subject.viewWillAppear()
            }

            it("presents a single article") {
                expect(view.viewModel?.articles.first).toNot(beNil())
            }
        }
    }
}

private class ArticleListViewStub: ArticleListView {
    var viewModel: ArticleListViewModel?
}
